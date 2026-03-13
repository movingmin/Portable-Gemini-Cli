@echo off
title Gemini CLI - Portable
setlocal

:: 1. 현재 디렉토리를 기준으로 경로 설정
set "PROJECT_ROOT=%~dp0"
set "PROJECT_ROOT=%PROJECT_ROOT:~0,-1%"

:: 2. 로컬 환경변수 격리 (PC에 기록을 남기지 않음)
:: USERPROFILE을 config로 설정하여 config\.gemini\settings.json을 바로 읽게 함
set "HOME=%PROJECT_ROOT%\config"
set "USERPROFILE=%PROJECT_ROOT%\config"
set "APPDATA=%PROJECT_ROOT%\config\AppData\Roaming"
set "LOCALAPPDATA=%PROJECT_ROOT%\config\AppData\Local"
set "TEMP=%PROJECT_ROOT%\cache\temp"
set "TMP=%PROJECT_ROOT%\cache\temp"
if not exist "%TEMP%" mkdir "%TEMP%"

:: 3. 모든 캐시 경로를 루트의 cache 폴더로 강제 고정
set "NPM_CONFIG_CACHE=%PROJECT_ROOT%\cache"
set "npm_config_cache=%PROJECT_ROOT%\cache"
set "XDG_CACHE_HOME=%PROJECT_ROOT%\cache"
set "PIP_CACHE_DIR=%PROJECT_ROOT%\cache\pip"

:: 4. Python 격리 및 가상화 설정
set "PYTHONHOME=%PROJECT_ROOT%\python"
set "PYTHONUSERBASE=%PROJECT_ROOT%\python\portable_packages"
set "PYTHONPATH=%PROJECT_ROOT%\python\portable_packages\lib\site-packages;%PROJECT_ROOT%\python\Lib;%PROJECT_ROOT%\python\Lib\site-packages"
set "PYTHONNOUSERSITE=1"
set "PIP_USER=true"

:: 5. Node, NPM, Python 경로 설정 (포터블 파이썬 경로 반영)
set "PYTHON_PATH=%PROJECT_ROOT%\python"
set "PATH=%PROJECT_ROOT%\node;%PROJECT_ROOT%\python;%PROJECT_ROOT%\python\Scripts;%PROJECT_ROOT%\python\portable_packages\Scripts;%PATH%"
set "NODE_PATH=%PROJECT_ROOT%\node_modules"
set "NPM_CONFIG_PREFIX=%PROJECT_ROOT%\node"
set "NODE_OPTIONS=--no-warnings"

:: 6. Chrome 경로 검색 및 설정
for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" /ve 2^>nul') do set "CHROME_PATH=%%b"
if not defined CHROME_PATH (
    for /f "tokens=2*" %%a in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" /ve 2^>nul') do set "CHROME_PATH=%%b"
)
if defined CHROME_PATH (
    set "GOOGLE_CHROME_BIN=%CHROME_PATH%"
)

:: Playwright 브라우저가 저장될 경로를 USB의 cache 폴더로 강제 지정
set "PLAYWRIGHT_BROWSERS_PATH=%PROJECT_ROOT%\cache\ms-playwright"

:: CLI 안깔려있으면깔아줌
if not exist "%PROJECT_ROOT%\node_modules\@google\gemini-cli\dist\index.js" (
    echo [INFO] Gemini CLI is missing. Installing for the first time...
    call npm install @google/gemini-cli
    if errorlevel 1 (
        echo [ERROR] Failed to install Gemini CLI. Check your internet connection.
        pause
        exit /b
    )
    echo [INFO] Gemini CLI installed successfully.
)

:: 7. patch-sandbox.js를 통한 샌드박스 우회 및 CLI 실행
echo [INFO] Starting Gemini CLI...
node -r "%PROJECT_ROOT%\patch-sandbox.js" "%PROJECT_ROOT%\node_modules\@google\gemini-cli\dist\index.js" %*

:: 8. 종료 후 리포트를 볼 수 있도록 무조건 일시정지
echo.
echo [INFO] Gemini CLI session ended.
echo Press any key to close this window...
pause > nul

endlocal
