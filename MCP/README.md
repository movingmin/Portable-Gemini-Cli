# Model Context Protocol (MCP) Servers

이 디렉터리는 Gemini CLI에서 사용하는 MCP(Model Context Protocol) 서버들을 포함하고 있습니다. 각 서버는 최초 실행 전 의존성 설치가 필요합니다.

## 1. 개별 MCP 서버 설치 및 설정

모든 설치 명령은 프로젝트 루트가 아닌 각 서버의 디렉터리로 이동 후 실행해야 합니다.

### github-server (Node.js)
- **위치**: `MCP/github-server`
- **설치**: `../../node/npm install` 실행

### Office-Word-MCP-Server (Python)
- **위치**: `MCP/Office-Word-MCP-Server`
- **설치**: `../../python/python.exe setup_mcp.py`를 실행하여 환경 구성 및 서버 설정을 진행하세요.

### Office-PowerPoint-MCP-Server (Python)
- **위치**: `MCP/Office-PowerPoint-MCP-Server`
- **설치**: `../../python/python.exe -m pip install -r requirements.txt` 실행 (또는 별도의 setup 스크립트 확인)

### playwright-MCP-Server (Node.js)
- **위치**: `MCP/playwright-MCP-Server`
- **설치**: `../../node/npm install` 실행

## 2. Playwright 브라우저 설치
브라우저 자동화 도구를 사용하려면 브라우저 바이너리가 필요합니다. 프로젝트 루트에서 다음 명령어를 실행하여 USB 내 `cache/` 폴더에 브라우저를 설치합니다.
```cmd
node\npx playwright install chromium
```

## 3. 설정 반영
설치가 완료된 MCP 서버들은 `./config/.gemini/settings.json` 파일의 `mcpServers` 항목에 올바른 경로와 인자로 등록되어야 Gemini CLI에서 인식할 수 있습니다.
