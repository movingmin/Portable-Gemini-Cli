# Model Context Protocol (MCP) Servers

이 디렉터리는 Gemini CLI에서 사용하는 MCP(Model Context Protocol) 서버들을 포함하고 있습니다. 각 서버는 최초 실행 전 의존성 설치가 필요합니다.

## 1. 개별 MCP 서버 역할 및 설정

모든 설치 명령은 프로젝트 루트가 아닌 각 서버의 디렉터리로 이동 후 실행해야 합니다.

### 🐙 github-server (Node.js)
- **역할**: GitHub API를 통해 리포지토리 조회, 이슈 생성/수정, 코드 검색 및 풀 리퀘스트 관리를 수행합니다.
- **위치**: `MCP/github-server`
- **설치**: `../../node/npm install` 실행

### 📝 notionApi (Node.js/npx)
- **역할**: Notion API를 통해 데이터베이스 조회, 페이지 생성/수정, 콘텐츠 관리를 수행합니다.
- **위치**: `../cache/` 디렉터리 아래에 npx로 설치
- **설치**: `../../node/npx -y @notionhq/notion-mcp-server` ## settings.json에 작성되어 있어서 최초실행시 자동설치(설정파일에 NOTION_TOKEN="YOUR_NOTION_TOKEN_HERE" 입력 필요)

### 📊 excel (Python)
- **역할**: Excel 파일(.xlsx, .csv)의 데이터를 읽고 쓰고, 셀 서식 및 시트 구조를 자동화합니다.
- **위치**: `MCP/excel-mcp-server`
- **설치**: `../../python/python.exe -m pip install -r requirements.txt` 실행

### 📝 word-document-server (Python)
- **역할**: Microsoft Word 문서(.docx) 생성, 텍스트 삽입, 이미지 배치, 각주/미주 관리 및 PDF 변환을 지원합니다.
- **위치**: `MCP/Office-Word-MCP-Server`
- **설치**: `../../python/python.exe setup_mcp.py`를 실행하여 환경 구성 및 서버 설정을 진행하세요.

### 🖼️ ppt-server (Python)
- **역할**: PowerPoint 슬라이드(.pptx) 생성, 레이아웃 관리, 텍스트 박스 및 이미지의 정밀한 위치 배치를 자동화합니다.
- **위치**: `MCP/Office-PowerPoint-MCP-Server`
- **설치**: `../../python/python.exe -m pip install -r requirements.txt` 실행

### 🔍 playwright-MCP-Server (Node.js)
- **역할**: 크로미움 브라우저를 직접 제어하여 웹 페이지 탐색, 클릭, 폼 입력, 스크린샷 캡처 및 복잡한 웹 상호작용을 수행합니다.
- **위치**: `MCP/playwright-MCP-Server`
- **설치**: `../../node/npm install` 실행

### 🔍 chrome-devtools (Node.js/npx)
- **역할**: 크롬 개발자 도구를 통해 웹 페이지의 DOM 구조를 분석하고, CSS 스타일을 검사하며, JavaScript 코드를 실행하여 동적인 웹 콘텐츠를 제어합니다.
- **위치**: `../cache/` 디렉터리 아래에 npx로 설치
- **설치**: `../../node/npx -y chrome-devtools-mcp@latest` ## settings.json에 작성되어 있어서 최초실행시 자동설치

### 📡 fetch (Node.js/npx)
- **역할**: HTTP/HTTPS 프로토콜을 사용하여 웹 리소스에 접근하고 데이터를 가져옵니다. REST API 호출, 파일 다운로드, 웹 콘텐츠 스크래핑 등 범용적인 네트워크 통신을 지원합니다.
- **위치**: `../cache/` 디렉터리 아래에 npx로 설치
- **설치**: `../../node/npx -y mcp-fetch-server` ## settings.json에 작성되어 있어서 최초실행시 자동설치

### 📦 kubernetes (Node.js/npx) (**아직 사용 되는지 확인 안됨**)
- **역할**: 쿠버네티스 클러스터의 리소스를 관리하고 모니터링합니다. Pod, Service, Deployment, ConfigMap 등 다양한 쿠버네티스 리소스를 조회, 생성, 수정, 삭제할 수 있습니다.
- **위치**: `../cache/` 디렉터리 아래에 npx로 설치
- **설치**: `../../node/npx -y kubernetes-mcp-server@latest` ## settings.json에 작성되어 있어서 최초실행시 자동설치

## 2. Playwright 브라우저 설치
Playwright 브라우저 자동화 도구를 실행하지 못하는 경우, 브라우저 바이너리가 필요할 수도 있습니다.. 프로젝트 루트에서 다음 명령어를 실행하여 USB 내 `cache/` 폴더에 브라우저를 설치합니다.
```cmd
node\npx playwright install chromium
```

## 3. 설정 반영
설치가 완료된 MCP 서버들은 `./config/.gemini/settings.json` 파일의 `mcpServers` 항목에 올바른 경로와 인자로 등록되어야 Gemini CLI에서 인식할 수 있습니다.
