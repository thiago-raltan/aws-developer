# parse-exam.ps1 — converte formato raw do exam Marek para markdown estruturado
# Uso: .\tools\parse-exam.ps1 -File BancoDeProva\Prova_marek_02.md
param([string]$File)

$baseDir = "c:\Users\thiag\OneDrive\Área de Trabalho\AWS-DEVELOPER"
$inputPath = Join-Path $baseDir $File
$utf8 = [System.Text.Encoding]::UTF8

function Parse-ExamFile([string]$path) {
    $raw = [System.IO.File]::ReadAllText($path, $utf8)
    $raw = $raw.Replace("`r`n","`n").Replace("`r","`n").Trim()

    # Quebra em blocos por "Pergunta N" (linha exata)
    $blockMatches = [regex]::Matches($raw, '(?ms)(?:^|\n)(Pergunta \d+\n.+?)(?=\nPergunta \d+\n|\z)')
    $blocks = @($blockMatches | ForEach-Object { $_.Groups[1].Value.Trim() })

    $results = [System.Collections.ArrayList]::new()

    foreach ($block in $blocks) {
        $lines = $block.Split("`n")
        if ($lines.Count -lt 2) { continue }

        # Linha 0: "Pergunta N", Linha 1: status (ignorar)
        $num = [regex]::Match($lines[0], '\d+').Value

        # Domínio (últimas 2 linhas: "Domínio\n[nome]")
        $domain = "Geral"
        $domIdx = -1
        for ($i = $lines.Count - 2; $i -ge 0; $i--) {
            if ($lines[$i] -eq 'Domínio') { $domIdx = $i; $domain = $lines[$i+1].Trim(); break }
        }

        # "Explicação geral" index
        $explIdx = -1
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -eq 'Explicação geral') { $explIdx = $i; break }
        }

        # Seção Q+Options: lines[2..explIdx-1]
        $qoEnd = if ($explIdx -gt 0) { $explIdx - 1 } else { if ($domIdx -gt 0) { $domIdx - 1 } else { $lines.Count - 1 } }
        $qoText = ($lines[2..$qoEnd] -join "`n").Trim()

        # Seção Explicação: lines[explIdx+1..domIdx-1]
        $explText = ""
        if ($explIdx -gt 0) {
            $explEnd = if ($domIdx -gt 0) { $domIdx - 1 } else { $lines.Count - 1 }
            if ($explIdx + 1 -le $explEnd) {
                $explText = ($lines[($explIdx+1)..$explEnd] -join "`n").Trim()
            }
        }

        # --- Parsear Q+Options ---
        # Quebra em parágrafos
        $paras = [System.Collections.ArrayList]::new()
        $cur = [System.Text.StringBuilder]::new()
        foreach ($ln in $qoText.Split("`n")) {
            if ($ln -eq '') {
                if ($cur.Length -gt 0) { [void]$paras.Add($cur.ToString().Trim()); $cur.Clear() | Out-Null }
            } else {
                if ($cur.Length -gt 0) { [void]$cur.Append("`n") }
                [void]$cur.Append($ln)
            }
        }
        if ($cur.Length -gt 0) { [void]$paras.Add($cur.ToString().Trim()) }

        # Achar índice do primeiro "Resposta correta"
        $firstRC = $paras.IndexOf('Resposta correta')
        $searchEnd = if ($firstRC -ge 0) { $firstRC } else { $paras.Count }

        # Achar último parágrafo com "?" antes do primeiro "Resposta correta"
        $lastQIdx = -1
        for ($i = $searchEnd - 1; $i -ge 0; $i--) {
            if ($paras[$i] -match '\?\s*$') { $lastQIdx = $i; break }
        }
        # Fallback: "select ... two/three" sem "?"
        if ($lastQIdx -lt 0) {
            for ($i = $searchEnd - 1; $i -ge 0; $i--) {
                if ($paras[$i] -match '(?i)(select|choose|selecione).*(two|three|dois|três|\d)') {
                    $lastQIdx = $i; break
                }
            }
        }
        # Fallback 2: parágrafo longo seguido de parágrafo curto
        if ($lastQIdx -lt 0) {
            for ($i = 1; $i -lt [Math]::Min($searchEnd, $paras.Count); $i++) {
                if ($paras[$i] -eq 'Resposta correta') { continue }
                if ($paras[$i-1].Length -gt 80 -and $paras[$i].Length -lt 300 -and $paras[$i].Split("`n").Count -le 2) {
                    $lastQIdx = $i - 1; break
                }
            }
        }
        # Fallback 3: tudo é texto de questão (sem opções identificáveis)
        if ($lastQIdx -lt 0 -and $firstRC -ge 0) { $lastQIdx = $firstRC - 1 }
        if ($lastQIdx -lt 0) { $lastQIdx = $paras.Count - 1 }

        # Montar texto da questão e opções
        $qTextParts = @()
        for ($i = 0; $i -le $lastQIdx; $i++) {
            if ($paras[$i] -ne 'Resposta correta') { $qTextParts += $paras[$i] }
        }

        $options = [System.Collections.ArrayList]::new()
        $expectCorrect = $false
        for ($i = $lastQIdx + 1; $i -lt $paras.Count; $i++) {
            $p = $paras[$i]
            if ($p -eq 'Resposta correta') { $expectCorrect = $true }
            else { [void]$options.Add([pscustomobject]@{text=$p; correct=$expectCorrect}); $expectCorrect = $false }
        }

        # Letras A, B, C, D, E, F
        $letters = 'A','B','C','D','E','F'
        $correctLetters = @()
        $optMd = @()
        for ($i = 0; $i -lt $options.Count; $i++) {
            $L = $letters[$i]
            $o = $options[$i]
            if ($o.correct) { $correctLetters += $L; $optMd += "- $L. **$($o.text)** ✅" }
            else { $optMd += "- $L. $($o.text)" }
        }
        $ansStr = if ($correctLetters.Count -gt 0) { $correctLetters -join ", " } else { "?" }

        # Limpar explicação
        $expl = $explText
        $expl = [regex]::Replace($expl, '(?m)^Correct options?:\s*$[\r\n]*', '')
        $expl = [regex]::Replace($expl, '(?m)^Incorrect options?:\s*$[\r\n]*', '')
        $expl = [regex]::Replace($expl, '(?m)^ ?via\s*[-–]\s*https?://[^\n]+[\r\n]*', '')
        $expl = [regex]::Replace($expl, '(?ms)\n?References?:\n(https?://[^\n]+\n?)+', '')
        $expl = $expl.Trim() -replace '\n{3,}', "`n`n"

        [void]$results.Add([pscustomobject]@{
            num       = $num
            domain    = $domain
            qText     = ($qTextParts -join "`n`n").Trim()
            optMd     = $optMd
            answer    = $ansStr
            expl      = $expl
        })
    }
    return $results
}

# --- Main ---
if (-not $File) { Write-Error "Use: .\tools\parse-exam.ps1 -File BancoDeProva\Prova_marek_02.md"; exit 1 }
if (-not (Test-Path $inputPath)) { Write-Error "Arquivo não encontrado: $inputPath"; exit 1 }

$questions = Parse-ExamFile $inputPath

Write-Host "Parseado: $($questions.Count) questões" -ForegroundColor Cyan
foreach ($q in $questions) {
    Write-Host "  Q$($q.num) [$($q.domain)] → Resp:$($q.answer) | Opts:$($q.optMd.Count)" -ForegroundColor Gray
}
