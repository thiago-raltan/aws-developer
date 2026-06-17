<#
.SYNOPSIS
  Constrói o simulado de questões no estudo.html a partir dos arquivos .md em
  Conteudo/06-Questao por dominio/<Dominio>/questoes-<Dominio>.md.

.DESCRIPTION
  Formato esperado das questões (por bloco, separados por linha "---"):

    ## Q1

    [ENUNCIADO]
    Texto da pergunta. Pode ocupar várias linhas.
    Continua até o próximo marcador.

    [A] Texto da alternativa A (uma linha apenas).
    [B] Texto da alternativa B.
    [C] Texto da alternativa C.
    [D] Texto da alternativa D.

    [RESPOSTA] C

    [EXPLICACAO]
    Texto da explicação. Pode ocupar várias linhas.

    ---

  Regras estritas (parser falha alto e claro se violadas):
    - Cada bloco DEVE conter [ENUNCIADO], pelo menos 2 alternativas,
      [RESPOSTA] e [EXPLICACAO].
    - Cada alternativa [A]..[E] é UMA linha.
    - [RESPOSTA] é uma única letra (A-E) ou letras separadas por vírgula.

.PARAMETER Convert
  Converte os .md no formato antigo para o novo formato estruturado
  (operação única de migração).

.PARAMETER Build
  Lê os .md no novo formato e atualiza estudo.html com o JSON do simulado.
  É a operação padrão.

.EXAMPLE
  .\tools\build-quiz.ps1 -Convert     # migra arquivos antigos
  .\tools\build-quiz.ps1               # atualiza HTML (modo Build)
#>

[CmdletBinding()]
param(
  [switch]$Convert,
  [switch]$Build
)

$ErrorActionPreference = 'Stop'

# Resolve workspace root (script lives em tools/)
$Root     = Split-Path -Parent $PSScriptRoot
$HtmlFile = Join-Path $Root 'estudo.html'
$QBase    = Join-Path $Root 'Conteudo\06-Questao por dominio'

$Domains = @(
  [pscustomobject]@{ Id='Dominio1-Desenvolvimento'; File='Dominio1-Desenvolvimento\questoes-Dominio1-Desenvolvimento.md' }
  [pscustomobject]@{ Id='Dominio2-Seguranca';       File='Dominio2-Seguranca\questoes-Dominio2-Seguranca.md' }
  [pscustomobject]@{ Id='Dominio3-Implantacao';     File='Dominio3-Implantacao\questoes-Dominio3-Implantacao.md' }
  [pscustomobject]@{ Id='Dominio4-Troubleshooting'; File='Dominio4-Troubleshooting\questoes-Dominio4-Troubleshooting.md' }
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
function Read-Utf8([string]$path) {
  return [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
}

function Write-Utf8([string]$path, [string]$text) {
  [System.IO.File]::WriteAllText($path, $text, [System.Text.Encoding]::UTF8)
}

function Esc-Json([string]$s) {
  if ($null -eq $s) { return '' }
  $s = $s.Replace('\','\\')
  $s = $s.Replace('"','\"')
  $s = $s.Replace("`r`n",' ')
  $s = $s.Replace("`n",' ')
  $s = $s.Replace("`t",' ')
  # collapse repeated spaces
  $s = [regex]::Replace($s, '\s{2,}', ' ').Trim()
  return $s
}

# ---------------------------------------------------------------------------
# NEW FORMAT PARSER — strict, fails loud
# ---------------------------------------------------------------------------
function Parse-Quizzes([string]$mdFile) {
  $raw    = Read-Utf8 $mdFile
  $blocks = [regex]::Split($raw, '\r?\n---\r?\n')
  $out    = New-Object System.Collections.Generic.List[hashtable]

  $blockIdx = 0
  foreach ($block in $blocks) {
    $blockIdx++
    $b = $block.Trim()
    if (-not ($b -match '^##\s*Q')) { continue }

    $num = ''
    if ($b -match '^##\s*Q[^\d]*([0-9]+)') { $num = $Matches[1] }

    $lines = $b -split '\r?\n'

    $section   = ''
    $enunciado = New-Object System.Collections.Generic.List[string]
    $opts      = [ordered]@{}
    $resposta  = ''
    $explic    = New-Object System.Collections.Generic.List[string]

    foreach ($line in $lines) {
      $t = $line.TrimEnd()
      $tt = $t.Trim()

      # Question header
      if ($tt -match '^##\s*Q') { continue }

      # Field markers
      if ($tt -match '^\[ENUNCIADO\]\s*(.*)$') {
        $section = 'enunciado'
        $rest = $Matches[1].Trim()
        if ($rest -ne '') { $enunciado.Add($rest) }
        continue
      }
      if ($tt -match '^\[([A-E])\]\s+(.+)$') {
        $section = 'option'
        $opts[$Matches[1]] = $Matches[2].Trim()
        continue
      }
      if ($tt -match '^\[RESPOSTA\]\s*(.+)$') {
        $section = 'resposta'
        $resposta = ($Matches[1].Trim().ToUpper() -replace '\s','')
        continue
      }
      if ($tt -match '^\[EXPLICACAO\]\s*(.*)$') {
        $section = 'explicacao'
        $rest = $Matches[1].Trim()
        if ($rest -ne '') { $explic.Add($rest) }
        continue
      }

      # Continuation lines
      switch ($section) {
        'enunciado'  { if ($tt -ne '') { $enunciado.Add($tt) } }
        'explicacao' { if ($tt -ne '' -or $explic.Count -gt 0) { $explic.Add($tt) } }
        # Options não suportam continuação (regra: alternativa = uma linha).
        # Resposta tampouco.
      }
    }

    # Validation
    $errors = New-Object System.Collections.Generic.List[string]
    if ($enunciado.Count -eq 0)     { $errors.Add('sem [ENUNCIADO]') }
    if ($opts.Count -lt 2)          { $errors.Add("apenas $($opts.Count) alternativas") }
    if ($resposta -eq '')           { $errors.Add('sem [RESPOSTA]') }
    if (-not ($resposta -match '^([A-E])(,[A-E])*$')) { $errors.Add("resposta inválida: '$resposta'") }
    if ($explic.Count -eq 0)        { $errors.Add('sem [EXPLICACAO]') }
    foreach ($letter in $resposta -split ',') {
      if (-not $opts.Contains($letter)) { $errors.Add("resposta '$letter' não corresponde a alternativa") }
    }

    if ($errors.Count -gt 0) {
      Write-Host "  [ERRO] Q$num (bloco #$blockIdx): $($errors -join '; ')" -ForegroundColor Red
      continue
    }

    $out.Add(@{
      num         = $num
      enunciado   = ($enunciado -join ' ')
      opts        = $opts
      resposta    = $resposta
      explicacao  = ($explic -join ' ')
    })
  }
  return ,$out
}

# ---------------------------------------------------------------------------
# BUILD: parse → JSON → injeta em estudo.html
# ---------------------------------------------------------------------------
function Build-Quizzes {
  if (-not (Test-Path $HtmlFile)) { throw "estudo.html não encontrado: $HtmlFile" }
  $html = Read-Utf8 $HtmlFile
  $totalErrors = 0

  foreach ($d in $Domains) {
    $md = Join-Path $QBase $d.File
    if (-not (Test-Path $md)) { Write-Host "  [SKIP] arquivo não existe: $md" -ForegroundColor Yellow; continue }

    Write-Host "→ $($d.Id)"
    $questions = Parse-Quizzes $md
    Write-Host "  $($questions.Count) questões válidas"

    # Build JSON
    $parts = New-Object System.Collections.Generic.List[string]
    foreach ($q in $questions) {
      $optList = New-Object System.Collections.Generic.List[string]
      foreach ($k in $q.opts.Keys) {
        $optList.Add('"' + $k + '":"' + (Esc-Json $q.opts[$k]) + '"')
      }
      $parts.Add('{"num":"' + (Esc-Json $q.num) +
                 '","q":"'  + (Esc-Json $q.enunciado) +
                 '","opts":{' + ($optList -join ',') +
                 '},"ans":"' + $q.resposta +
                 '","exp":"'  + (Esc-Json $q.explicacao) + '"}')
    }
    $json = '[' + ($parts -join ',') + ']'

    # Replace article in HTML
    $marker = '<article id="topic-06-Questao-por-dominio__' + $d.Id + '"'
    $start  = $html.IndexOf($marker)
    if ($start -lt 0) { Write-Host "  [ERRO] article não encontrado no HTML" -ForegroundColor Red; $totalErrors++; continue }
    $end    = $html.IndexOf('</article>', $start) + '</article>'.Length

    $newArticle = '<article id="topic-06-Questao-por-dominio__' + $d.Id +
                  '" class="topic-content hidden" data-domain="06-Questao-por-dominio">' + "`n" +
                  '<div class="quiz-wrapper" id="quiz-' + $d.Id +
                  '" data-questions=''' + $json + '''></div>' + "`n" +
                  '</article>'
    $html = $html.Substring(0, $start) + $newArticle + $html.Substring($end)
    Write-Host "  HTML atualizado." -ForegroundColor Green
  }

  Write-Utf8 $HtmlFile $html
  if ($totalErrors -gt 0) { Write-Host "Concluído com $totalErrors erros." -ForegroundColor Yellow }
  else { Write-Host "`nBuild concluído com sucesso." -ForegroundColor Green }
}

# ---------------------------------------------------------------------------
# CONVERT: parser legado (formato antigo) → escreve novo formato
# ---------------------------------------------------------------------------
function Parse-Legacy([string]$mdFile) {
  $raw    = Read-Utf8 $mdFile
  $blocks = [regex]::Split($raw, '\r?\n---\r?\n')
  $out    = New-Object System.Collections.Generic.List[hashtable]

  foreach ($block in $blocks) {
    $b = $block.Trim()
    if (-not ($b -match '## Quest')) { continue }
    $num = ''; if ($b -match '## Quest[^0-9]*([0-9]+)') { $num = $Matches[1] }

    # Split block at **Resposta:** marker
    $rxAns = [regex]'\r?\n\*\*Resposta:\s*([A-Za-z,\s]+)\*\*'
    $m = $rxAns.Match($b)
    if (-not $m.Success) { continue }

    $beforeAns = $b.Substring(0, $m.Index)
    $afterAns  = $b.Substring($m.Index + $m.Length)
    $rawAnswer = $m.Groups[1].Value

    $answer = ($rawAnswer.Trim().ToUpper() -replace '[\s,]','')
    if ($answer.Length -gt 1) { $answer = ($answer.ToCharArray() -join ',') }

    # Parse options + question from beforeAns
    $linesBefore = $beforeAns -split '\r?\n'
    $qLines = New-Object System.Collections.Generic.List[string]
    $opts   = [ordered]@{}
    $curLetter = ''
    $inOptions = $false

    foreach ($line in $linesBefore) {
      $lt = $line.Trim()
      if ($lt -match '^##\s+Quest') { continue }

      # dashed option: - A. text   |   - A text   |   -A.text
      if ($lt -match '^-\s*([A-E])[\.\s)](.*)$') {
        $curLetter = $Matches[1].ToUpper()
        $opts[$curLetter] = $Matches[2].Trim()
        $inOptions = $true
        continue
      }
      # dashless option BEFORE answer (e.g. "E.Texto"):
      if ($inOptions -and $lt -match '^([A-E])\.\s*(.+)$') {
        $curLetter = $Matches[1].ToUpper()
        if (-not $opts.Contains($curLetter)) {
          $opts[$curLetter] = $Matches[2].Trim()
          continue
        }
      }
      # continuation of current option
      if ($inOptions -and $curLetter -ne '' -and $lt -ne '' -and -not ($lt -match '^-')) {
        $opts[$curLetter] = $opts[$curLetter] + ' ' + $lt
        continue
      }
      # question text (before options started)
      if (-not $inOptions -and $lt -ne '') { $qLines.Add($lt) }
    }

    # Parse explanation from afterAns
    $expLines = New-Object System.Collections.Generic.List[string]
    foreach ($line in ($afterAns -split '\r?\n')) {
      $lt = $line.Trim()
      if ($lt -match '^\*\*Explica') { continue }
      if ($lt -ne '' -or $expLines.Count -gt 0) { $expLines.Add($lt) }
    }

    if ($opts.Count -lt 2) {
      Write-Host "  [SKIP legacy] Q$num (opts=$($opts.Count))" -ForegroundColor Yellow
      continue
    }

    $qtxt = (($qLines | Where-Object { $_ -ne '' }) -join ' ')
    $etxt = (($expLines | Where-Object { $_ -ne '' }) -join ' ')

    $qtxt = [regex]::Replace($qtxt, '\s{2,}', ' ').Trim()
    $etxt = [regex]::Replace($etxt, '\s{2,}', ' ').Trim()
    $clean = [ordered]@{}
    foreach ($k in $opts.Keys) { $clean[$k] = [regex]::Replace($opts[$k], '\s{2,}', ' ').Trim() }

    $out.Add(@{ num=$num; enunciado=$qtxt; opts=$clean; resposta=$answer; explicacao=$etxt })
  }
  return ,$out
}

function Format-NewMd($questions, $domainName) {
  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine("# Questões — $domainName")
  [void]$sb.AppendLine('')
  [void]$sb.AppendLine('> Formato: cada bloco separado por `---`. Campos `[ENUNCIADO]`, `[A]`..`[E]`, `[RESPOSTA]`, `[EXPLICACAO]`.')
  [void]$sb.AppendLine('> Alternativas devem ocupar UMA linha. Enunciado e explicação podem ter múltiplas linhas.')
  [void]$sb.AppendLine('')
  [void]$sb.AppendLine('---')
  [void]$sb.AppendLine('')

  foreach ($q in $questions) {
    [void]$sb.AppendLine("## Q$($q.num)")
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine('[ENUNCIADO]')
    [void]$sb.AppendLine($q.enunciado)
    [void]$sb.AppendLine('')
    foreach ($k in $q.opts.Keys) {
      [void]$sb.AppendLine("[$k] $($q.opts[$k])")
    }
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine("[RESPOSTA] $($q.resposta)")
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine('[EXPLICACAO]')
    [void]$sb.AppendLine($q.explicacao)
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine('---')
    [void]$sb.AppendLine('')
  }
  return $sb.ToString()
}

function Convert-LegacyFiles {
  foreach ($d in $Domains) {
    $md = Join-Path $QBase $d.File
    if (-not (Test-Path $md)) { Write-Host "  [SKIP] $md" -ForegroundColor Yellow; continue }

    Write-Host "→ Convertendo $($d.Id)"
    $backup = "$md.legacy.bak"
    if (-not (Test-Path $backup)) {
      Copy-Item $md $backup
      Write-Host "  Backup criado: $backup"
    }

    $questions = Parse-Legacy $md
    Write-Host "  $($questions.Count) questões extraídas"

    $newContent = Format-NewMd $questions $d.Id
    Write-Utf8 $md $newContent
    Write-Host "  Salvo em formato novo." -ForegroundColor Green
  }
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
if ($Convert) {
  Write-Host "=== CONVERTENDO arquivos legados → novo formato ===" -ForegroundColor Cyan
  Convert-LegacyFiles
  Write-Host ''
  Write-Host "Conversão concluída. Rode novamente sem -Convert para atualizar o HTML." -ForegroundColor Cyan
  return
}

# Default: build
Write-Host "=== BUILD: gerando simulado no estudo.html ===" -ForegroundColor Cyan
Build-Quizzes
