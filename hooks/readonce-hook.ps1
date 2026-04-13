# ReadOnce: 같은 세션에서 동일 파일 중복 읽기 차단 (Windows PowerShell 버전)
# - offset/limit 지정된 분할 읽기는 허용 (대규모 편집 시 필요)
# - 5분 이내 동일 범위 재읽기만 차단

$CacheDir = "$env:TEMP\claude-read-cache-$env:USERNAME"
if (-not (Test-Path $CacheDir)) { New-Item -ItemType Directory -Path $CacheDir -Force | Out-Null }

# stdin에서 JSON 입력 읽기
$Input = $input | Out-String
$json = $Input | ConvertFrom-Json

$ToolName = $json.tool_name
$FilePath = $json.tool_input.file_path
$Offset = $json.tool_input.offset

# Read 호출만 체크
if ($ToolName -ne "Read" -or -not $FilePath) { exit 0 }

# offset이 있으면 분할 읽기 → 항상 허용
if ($Offset -and $Offset -ne "None" -and $Offset -ne "0") { exit 0 }

# 경로 정규화
$NormPath = [System.IO.Path]::GetFullPath($FilePath)

# 해시로 캐시 파일명 생성
$Hash = [System.BitConverter]::ToString(
    [System.Security.Cryptography.MD5]::Create().ComputeHash(
        [System.Text.Encoding]::UTF8.GetBytes($NormPath)
    )
).Replace("-", "").ToLower()
$CacheFile = Join-Path $CacheDir $Hash

# 캐시 파일 존재 + 5분 이내면 차단
if (Test-Path $CacheFile) {
    $CachedTime = [int](Get-Content $CacheFile)
    $Now = [int][DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $Diff = $Now - $CachedTime

    if ($Diff -lt 300) {
        [Console]::Error.WriteLine("이 파일은 ${Diff}초 전에 이미 읽었습니다. 컨텍스트의 기존 내용을 사용하세요: $FilePath")
        exit 2
    }
}

# 현재 시간 기록
[DateTimeOffset]::UtcNow.ToUnixTimeSeconds() | Set-Content $CacheFile
exit 0
