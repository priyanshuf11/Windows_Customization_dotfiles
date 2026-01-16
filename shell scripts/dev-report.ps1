# ================= CONFIG =================
$Projects = "$env:USERPROFILE\Projects"
$Today = Get-Date -Format "yyyy-MM-dd"
$StartOfDay = (Get-Date).Date

$ExcludeDirs = @(
  "node_modules",
  ".git",
  ".next",
  "dist",
  "build",
  "out",
  ".turbo",
  ".cache"
)

# ================= FILE ACTIVITY =================
$ActiveFiles = Get-ChildItem $Projects -Recurse -Depth 4 -Directory -ErrorAction SilentlyContinue |
  Where-Object { $ExcludeDirs -notcontains $_.Name } |
  ForEach-Object {
    Get-ChildItem $_.FullName -File -ErrorAction SilentlyContinue |
      Where-Object { $_.LastWriteTime -ge $StartOfDay }
  }



$FilesChanged = $ActiveFiles.Count

$CodingSeconds = 0
if ($FilesChanged -gt 0) {
  $FirstEdit = ($ActiveFiles | Sort-Object LastWriteTime | Select-Object -First 1).LastWriteTime
  $LastEdit  = ($ActiveFiles | Sort-Object LastWriteTime | Select-Object -Last 1).LastWriteTime
  $CodingSeconds = ($LastEdit - $FirstEdit).TotalSeconds
}

$Hours = [int]($CodingSeconds / 3600)
$Minutes = [int](($CodingSeconds % 3600) / 60)

# ================= LANGUAGES =================
$Languages = $ActiveFiles |
  Where-Object { $_.Extension -match '\.(py|ts|js|java|cpp|c|rs|go)$' } |
  Group-Object Extension |
  Sort-Object Count -Descending |
  Select-Object -First 5 |
  ForEach-Object { $_.Name.TrimStart('.') }

$LangList = if ($Languages) { ($Languages -join ", ") } else { "none" }

# ================= GIT =================
$Commits = 0
$Repos = 0
$Added = 0
$Removed = 0

$GitRepos = Get-ChildItem $Projects -Recurse -Directory -ErrorAction SilentlyContinue |
  Where-Object {
    $_.Name -eq ".git" -and
    ($ExcludeDirs -notcontains $_.Parent.Name)
  } |
  ForEach-Object { $_.Parent.FullName }

foreach ($Repo in $GitRepos) {
  Push-Location $Repo
  try {
    $TodayCommits = git log --since="$Today 00:00" --oneline 2>$null
    if ($TodayCommits) {
      $Commits += $TodayCommits.Count
      $Repos++

      git log --since="$Today 00:00" --numstat 2>$null |
        ForEach-Object {
          if ($_ -match '^(\d+)\s+(\d+)') {
            $Added += [int]$Matches[1]
            $Removed += [int]$Matches[2]
          }
        }
    }
  } catch {}
  Pop-Location
}

# ================= SCORE =================
$Score = 0
if ($CodingSeconds -gt 7200) { $Score += 30 }
if ($Commits -gt 0)        { $Score += 20 }
if ($FilesChanged -gt 10)  { $Score += 15 }
if ($Repos -gt 1)          { $Score += 15 }
if ($Added -gt 0)          { $Score += 20 }

# ================= VERDICT =================
if ($Score -ge 80) {
  $Verdict = "Focused execution"
} elseif ($Score -ge 60) {
  $Verdict = "Deep work"
} elseif ($Score -ge 40) {
  $Verdict = "Light progress"
} else {
  $Verdict = "Human day"
}

# ================= BOX RENDER =================
$BoxWidth   = 44
$InnerWidth = $BoxWidth - 2
$LabelWidth = 18

function BoxLine($label, $value) {
  $content = "{0,-$LabelWidth}: {1}" -f $label, $value
  if ($content.Length -gt $InnerWidth) {
    $content = $content.Substring(0, $InnerWidth)
  }
  $padded = $content.PadRight($InnerWidth)
  Write-Host "│$padded│"
}

# ================= OUTPUT =================
Write-Host ""
Write-Host "┌$(('─' * $InnerWidth))┐"
Write-Host "│$('DAILY DEV ANALYSIS'.PadLeft(($InnerWidth + 19)/2).PadRight($InnerWidth))│"
Write-Host "├$(('─' * $InnerWidth))┤"

BoxLine "Date"              $Today
BoxLine "Coding span"       "$Hours h $Minutes m"
BoxLine "Files changed"     $FilesChanged

Write-Host "├$(('─' * $InnerWidth))┤"

BoxLine "Git commits"       $Commits
BoxLine "Repos touched"     $Repos
BoxLine "Lines + / -"       "+$Added / -$Removed"

Write-Host "├$(('─' * $InnerWidth))┤"

BoxLine "Languages used"    $LangList

Write-Host "├$(('─' * $InnerWidth))┤"

BoxLine "Productivity score" "$Score / 100"
BoxLine "Verdict"            $Verdict

Write-Host "└$(('─' * $InnerWidth))┘"
Write-Host ""
