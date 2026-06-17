##############################################################
# generate-marek-questoes.ps1 - Gera 8 MD files + HTML update
##############################################################
$ErrorActionPreference = "Stop"
$base  = (Get-Location).Path
$utf8  = New-Object System.Text.UTF8Encoding($false)

$domainConfig = [ordered]@{
    'Development'     = @{ folder='Dominio1-Desenvolvimento'; short='Dev';    label='Development'     }
    'Security'        = @{ folder='Dominio2-Seguranca';       short='Seg';    label='Security'        }
    'Deployment'      = @{ folder='Dominio3-Implantacao';     short='Deploy'; label='Deployment'      }
    'Troubleshooting' = @{ folder='Dominio4-Troubleshooting'; short='Troubl'; label='Troubleshooting' }
}

function Get-DomainKey($rawDomain) {
    if ($rawDomain -match 'Development')  { return 'Development'     }
    if ($rawDomain -match 'Security')     { return 'Security'        }
    if ($rawDomain -match 'Deployment')   { return 'Deployment'      }
    return 'Troubleshooting'
}

function EscJson($s) {
    $s = [string]$s
    $s = $s.Replace('\', '\\')
    $s = $s.Replace('"', '\"')
    $s = $s -replace '[\r\n]+', ' '
    $s = $s -replace '\s+', ' '
    $s = $s.Replace("'", '&#39;')
    $s = $s.Replace('&', '&amp;')
    $s = $s.Replace('&amp;#39;', '&#39;')
    return $s.Trim()
}

function Clean-Md($s) {
    $s = [string]$s
    $s = $s -replace '\*\*(.+?)\*\*', '$1'
    $s = $s -replace '\*(.+?)\*', '$1'
    $s = $s -replace '`(.+?)`', '$1'
    $s = $s -replace '^\s*-\s+', ''
    $s = $s.Replace([string][char]0x2705, '')
    return $s.Trim()
}

function Parse-Simulado($filePath, $provaNum) {
    $text = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    $questions = [System.Collections.Generic.List[object]]::new()
    $blocks = $text -split '(?m)^---\s*$'

    foreach ($block in $blocks) {
        $b = $block.Trim()
        if ($b -notmatch '(?m)^## Pergunta \d+') { continue }

        # Parse header from first line
        $headerLine = ($b -split '\r?\n')[0].Trim()
        if ($headerLine -notmatch '## Pergunta (\d+)') { continue }
        $num = $matches[1]

        $colonIdx = $headerLine.IndexOf(':')
        if ($colonIdx -lt 0) { continue }
        $rawDomain = $headerLine.Substring($colonIdx + 1).Trim()
        $dk = Get-DomainKey $rawDomain

        $lines    = $b -split '\r?\n'
        $qLines   = [System.Collections.Generic.List[string]]::new()
        $opts     = [ordered]@{}
        $ans      = ''
        $expLines = [System.Collections.Generic.List[string]]::new()
        $state    = 'skip'
        $checkmark = [string][char]0x2705

        foreach ($line in $lines) {
            if ($line -match '^## Pergunta') { $state = 'q'; continue }

            switch ($state) {
                'q' {
                    # BUG FIX: process option A here before switching state
                    if ($line -match '^- ([A-F])\. (.+)$') {
                        $state = 'opts'
                        $letter  = $matches[1]
                        $optText = $matches[2].TrimEnd()
                        if ($optText.EndsWith($checkmark)) { $optText = $optText.Substring(0, $optText.Length-1).TrimEnd() }
                        $optText = $optText -replace '^\*\*(.+)\*\*$', '$1'
                        $opts[$letter] = $optText.Trim()
                        break
                    }
                    if ($line.Trim()) { $qLines.Add($line.Trim()) }
                }
                'opts' {
                    # BUG FIX: extract answer directly here instead of delegating to 'ans' state
                    if ($line -match '^\*\*Resposta: (.+)\*\*') {
                        $ans   = ($matches[1].Trim()) -replace '\s', ''
                        $state = 'exp'
                        break
                    }
                    if ($line -match '^- ([A-F])\. (.+)$') {
                        $letter  = $matches[1]
                        $optText = $matches[2].TrimEnd()
                        if ($optText.EndsWith($checkmark)) { $optText = $optText.Substring(0, $optText.Length-1).TrimEnd() }
                        $optText = $optText -replace '^\*\*(.+)\*\*$', '$1'
                        $opts[$letter] = $optText.Trim()
                    }
                }
                'exp' {
                    # Skip the Explicacao header line
                    if ($line -match '^\*\*Explic') { break }
                    $expLines.Add($line)
                }
            }
        }

        $qText   = (($qLines -join ' ').Trim()) | ForEach-Object { Clean-Md $_ }
        $rawExp  = ($expLines | Where-Object { $_.Trim() }) -join ' '
        $expText = Clean-Md $rawExp

        $questions.Add([PSCustomObject]@{
            provaNum  = $provaNum
            num       = $num
            domain    = $dk
            rawDomain = $rawDomain
            qText     = $qText
            opts      = $opts
            ans       = $ans
            exp       = $expText
            rawBlock  = $b
        })
    }
    return $questions
}

# Parse all simulados
Write-Host "=== Parsing simulados ==="
$allQ = [System.Collections.Generic.List[object]]::new()
foreach ($n in 1..6) {
    $path = "$base\BancoDeProva\Prova_marek_0$n.md"
    $qs = Parse-Simulado $path $n
    foreach ($q in $qs) { $allQ.Add($q) }
    Write-Host "  Prova $n : $($qs.Count) questoes"
}
Write-Host "  TOTAL  : $($allQ.Count) questoes"

# Verify sample - Q1 Prova 1 opts and ans
$sample = $allQ | Where-Object { $_.provaNum -eq 1 -and $_.num -eq '1' } | Select-Object -First 1
if ($sample) {
    Write-Host "  [CHECK] P01-Q1 opts=$($sample.opts.Keys -join ',') ans=$($sample.ans)"
}

# Create MD files
Write-Host "`n=== Criando MD files ==="
$outBase = "$base\Conteudo\06-Questao por dominio"

foreach ($dk in $domainConfig.Keys) {
    $cfg = $domainConfig[$dk]
    foreach ($part in 1, 2) {
        $partProvas = if ($part -eq 1) { @(1,2,3) } else { @(4,5,6) }
        $partLabel  = if ($part -eq 1) { "01, 02, 03" } else { "04, 05, 06" }
        $partQs     = @($allQ | Where-Object { $_.domain -eq $dk -and $_.provaNum -in $partProvas })
        if ($partQs.Count -eq 0) { Write-Host "  [SKIP] $dk Part $part"; continue }

        $mdLines = [System.Collections.Generic.List[string]]::new()
        $mdLines.Add("# Simulado Marek - $($cfg.label)")
        $mdLines.Add("")
        $mdLines.Add("## Parte $part`: Provas $partLabel")
        $mdLines.Add("")
        $mdLines.Add("> **$($partQs.Count) questoes** agrupadas por dominio -- Fonte: Provas Marek $partLabel")
        $mdLines.Add("")

        foreach ($q in $partQs) {
            $mdLines.Add("---")
            $mdLines.Add("")
            $newBlock = $q.rawBlock -replace "(?m)^(## Pergunta $($q.num))\b", "`$1 [P0$($q.provaNum)]"
            $mdLines.Add($newBlock)
            $mdLines.Add("")
        }

        $outFile = "$outBase\$($cfg.folder)\marek_simulado-$dk-$part.md"
        [System.IO.File]::WriteAllText($outFile, ($mdLines -join "`n"), $utf8)
        Write-Host "  Created: marek_simulado-$dk-$part.md ($($partQs.Count) questoes)"
    }
}

# Build quiz JSON
function Build-QuizJson($questions) {
    $items = foreach ($q in $questions) {
        $optsJson = ($q.opts.GetEnumerator() | ForEach-Object {
            '"' + $_.Key + '":"' + (EscJson $_.Value) + '"'
        }) -join ','
        '{"num":"P0' + $q.provaNum + '-Q' + $q.num + '","q":"' + (EscJson $q.qText) + '","opts":{' + $optsJson + '},"ans":"' + $q.ans + '","exp":"' + (EscJson $q.exp) + '"}'
    }
    return '[' + ($items -join ',') + ']'
}

# Update HTML
Write-Host "`n=== Atualizando HTML ==="
$htmlPath = "$base\estudo.html"
$html = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)

# Remove previously added nav/articles (idempotent)
$html = $html -replace '(?m)\s*<li><a[^>]+marek-simulado[^>]+>[^<]*</a></li>', ''
$html = $html -replace '(?s)<article[^>]+marek-simulado[^>]+>.*?</article>', ''
$html = $html -replace '(?s)<div class="domain-group" data-domain="07-Questao-Marek">.*?</ul></div>', ''

# Build 07-Questao-Marek nav group
$navItems07 = ""
foreach ($dk in $domainConfig.Keys) {
    $cfg = $domainConfig[$dk]
    foreach ($part in 1, 2) {
        $partRange = if ($part -eq 1) { "P01-03" } else { "P04-06" }
        $topicId   = "06-Questao-por-dominio__marek-simulado-$dk-$part"
        $navLabel  = "$($cfg.label) * $partRange"
        $navItems07 += "`r`n<li><a href=`"#`" onclick=`"showTopic('$topicId');return false`" id=`"nav-07-marek-simulado-$dk-$part`">$navLabel</a></li>"
    }
}
$group07 = "`r`n`r`n    <div class=`"domain-group`" data-domain=`"07-Questao-Marek`">`r`n      <div class=`"domain-header`" onclick=`"toggleDomain('07-Questao-Marek')`" style=`"--dc:#f59e0b`">`r`n        <span class=`"d-icon`">🎯</span>`r`n        <span class=`"d-label`">07-Questao Marek</span>`r`n        <span class=`"d-chevron`">▾</span>`r`n      </div>`r`n      <ul class=`"topic-list`" id=`"list-07-Questao-Marek`">$navItems07`r`n</ul></div>"

# Insert group 07 after group 06 (position-based)
$g06start = $html.IndexOf('<div class="domain-group" data-domain="06-Questao-por-dominio">')
$g06end   = $html.IndexOf('</ul></div>', $g06start) + 11
$html = $html.Substring(0, $g06end) + $group07 + $html.Substring($g06end)

# Build article sections
$newArticles = ""
foreach ($dk in $domainConfig.Keys) {
    $cfg = $domainConfig[$dk]
    foreach ($part in 1, 2) {
        $partProvas = if ($part -eq 1) { @(1,2,3) } else { @(4,5,6) }
        $partQs = @($allQ | Where-Object { $_.domain -eq $dk -and $_.provaNum -in $partProvas })
        if ($partQs.Count -eq 0) { continue }

        $topicId  = "06-Questao-por-dominio__marek-simulado-$dk-$part"
        $quizId   = "quiz-marek-$dk-$part"
        $jsonData = Build-QuizJson $partQs

        $newArticles += "`n<article id=`"topic-$topicId`" class=`"topic-content hidden`" data-domain=`"06-Questao-por-dominio`">`n<div class=`"quiz-wrapper`" id=`"$quizId`" data-questions='$jsonData'></div>`n</article>"
    }
}

$d4Marker  = 'id="quiz-Dominio4-Troubleshooting"'
$d4Pos     = $html.IndexOf($d4Marker)
$closePos  = $html.IndexOf("</article>", $d4Pos)
$insertPos = $closePos + "</article>".Length
$html = $html.Substring(0, $insertPos) + $newArticles + $html.Substring($insertPos)

[System.IO.File]::WriteAllText($htmlPath, $html, $utf8)

# Validate
Write-Host "=== Validacao ==="
$htmlCheck = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)
foreach ($dk in $domainConfig.Keys) {
    foreach ($part in 1, 2) {
        $id = "quiz-marek-$dk-$part"
        if ($htmlCheck.Contains($id)) { Write-Host "  [OK] $id" }
        else { Write-Host "  [MISSING] $id" }
    }
}
Write-Host "`nDone!"