# start-portable-shell.ps1

$PROJECT_ROOT = $PSScriptRoot
$Host.UI.RawUI.WindowTitle = "Gemini Portable Shell"

# 로컬 환경변수 격리
$env:HOME = "$PROJECT_ROOT\config"
$env:USERPROFILE = "$PROJECT_ROOT\config"
$env:APPDATA = "$PROJECT_ROOT\config\AppData\Roaming"
$env:LOCALAPPDATA = "$PROJECT_ROOT\config\AppData\Local"
$env:TEMP = "$PROJECT_ROOT\cache\temp"
$env:TMP = "$PROJECT_ROOT\cache\temp"
$env:HF_HOME = "$PROJECT_ROOT\cache\huggingface"
$env:HF_HUB_DISABLE_SYMLINKS_WARNING = "1"
$env:PY2ZH_CACHE = "$PROJECT_ROOT\cache\pdf2zh"

if (-not (Test-Path -Path $env:TEMP)) {
    New-Item -ItemType Directory -Path $env:TEMP -Force | Out-Null
}

# 캐시 경로 강제 고정
$env:NPM_CONFIG_CACHE = "$PROJECT_ROOT\cache"
$env:npm_config_cache = "$PROJECT_ROOT\cache"
$env:XDG_CACHE_HOME = "$PROJECT_ROOT\cache"
$env:PIP_CACHE_DIR = "$PROJECT_ROOT\cache\pip"

# Python 격리
$env:PYTHONHOME = "$PROJECT_ROOT\python"
$env:PYTHONUSERBASE = "$PROJECT_ROOT\python\portable_packages"
$env:PYTHONPATH = "$PROJECT_ROOT\python\portable_packages\lib\site-packages;$PROJECT_ROOT\python\Lib;$PROJECT_ROOT\python\Lib\site-packages"
$env:PYTHONNOUSERSITE = "1"
$env:PIP_USER = "true"

# PATH 및 Node 설정
$env:PYTHON_PATH = "$PROJECT_ROOT\python"
$env:PATH = "$PROJECT_ROOT\node;$PROJECT_ROOT\python;$PROJECT_ROOT\python\Scripts;$PROJECT_ROOT\python\portable_packages\Scripts;$env:PATH"
$env:NODE_PATH = "$PROJECT_ROOT\node_modules"
$env:NPM_CONFIG_PREFIX = "$PROJECT_ROOT\node"
$env:NODE_OPTIONS = "--no-warnings"

# Chrome 경로 검색
$chromePath = $null
$regPathHKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe"
$regPathHKCU = "HKCU:\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe"

if (Test-Path $regPathHKLM) {
    $chromePath = (Get-ItemProperty -Path $regPathHKLM -Name "(default)" -ErrorAction SilentlyContinue)."(default)"
}
if ([string]::IsNullOrWhiteSpace($chromePath) -and (Test-Path $regPathHKCU)) {
    $chromePath = (Get-ItemProperty -Path $regPathHKCU -Name "(default)" -ErrorAction SilentlyContinue)."(default)"
}

if (-not [string]::IsNullOrWhiteSpace($chromePath)) {
    $env:GOOGLE_CHROME_BIN = $chromePath
}

$env:PLAYWRIGHT_BROWSERS_PATH = "$PROJECT_ROOT\cache\ms-playwright"

Write-Host "[INFO] Portable PowerShell Environment Ready." -ForegroundColor Cyan