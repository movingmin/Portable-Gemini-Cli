@echo off
title Gemini Web - Portable
setlocal

:: 1. 루트 경로 설정 (WebApps 폴더에서 한 단계 위인 H:\gemini-Cli를 기준으로 설정)
set "PROJECT_ROOT=%~dp0.."

:: 2. 로컬 환경변수 격리
set "HOME=%PROJECT_ROOT%\config"
set "USERPROFILE=%PROJECT_ROOT%\config"
set "APPDATA=%PROJECT_ROOT%\config\AppData\Roaming"
set "LOCALAPPDATA=%PROJECT_ROOT%\config\AppData\Local"
set "TEMP=%PROJECT_ROOT%\cache\temp"
set "TMP=%PROJECT_ROOT%\cache\temp"

:: 3. 실행 파일 및 데이터 폴더 경로 설정
set "CHROME_BIN=%PROJECT_ROOT%\cache\ms-playwright\chromium-1208\chrome-win64\chrome.exe"
set "USER_DATA=%PROJECT_ROOT%\config\AppData\Local\ms-playwright\user_data"

:: 4. 폴더 생성 및 실행
if not exist "%TEMP%" mkdir "%TEMP%"
if not exist "%USER_DATA%" mkdir "%USER_DATA%"

echo [INFO] Starting Gemini Web in Isolated Environment...
start "" "%CHROME_BIN%" --user-data-dir="%USER_DATA%" --app="https://gemini.google.com/" --start-maximized

endlocal
