@echo off
title Chromium - Portable
setlocal

:: 1. 루트 및 환경 변수 설정
set "PROJECT_ROOT=%~dp0.."
set "USERPROFILE=%PROJECT_ROOT%\config"
set "APPDATA=%PROJECT_ROOT%\config\AppData\Roaming"
set "LOCALAPPDATA=%PROJECT_ROOT%\config\AppData\Local"

:: 2. 브라우저 및 데이터 경로 설정 
set "CHROME_BIN=%PROJECT_ROOT%\cache\ms-playwright\chromium-1208\chrome-win64\chrome.exe"
set "USER_DATA=%PROJECT_ROOT%\config\AppData\Local\ms-playwright\user_data"

:: 3. 실행 
if not exist "%USER_DATA%" mkdir "%USER_DATA%"
start "" "%CHROME_BIN%" --user-data-dir="%USER_DATA%" --no-first-run --no-default-browser-check --start-maximized

endlocal
