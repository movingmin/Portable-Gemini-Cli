# Gemini CLI Portable

이 프로젝트는 Google의 **Gemini 개발자용 CLI(@google/gemini-cli)** 를 데스크탑 환경이나 호스트 PC에 어떠한 흔적도 남기지 않고, USB나 외장 하드에서 **완벽하게 포터블(Portable)로 구동**하기 위해 만들어졌습니다.

또한 샌드박스 제한을 패치로 우회하여, 호스트 PC의 어떤 경로든 자유롭게 읽고 쓸 수 있도록 확장되었습니다.

## 1. 요구 사항 및 환경 구성

새로운 환경에서 구동하기 전, 아래 두 폴더를 프로젝트 루트(`./`)에 준비해 주세요.

- **Node.js (`node/` 폴더)**:
  - **링크**: [Node.js 정식 다운로드](https://nodejs.org/ko/download)
  - **방법**: Windows용 `.zip` (64-bit) 파일을 다운로드하여 압축 해제
  - **위치**: `./node/` (내부에 `node.exe`가 바로 위치해야 함)
- **Python (`python/` 폴더)**:
  - **링크**: [Python Windows Releases](https://www.python.org/downloads/windows/)
  - **방법**: `Windows embeddable package` 다운로드하여 압축 해제
  - **위치**: `./python/` (내부에 `python.exe`가 바로 위치해야 함)

## 2. MCP 서버 및 브라우저 환경 설정

상세한 MCP 서버 설치 방법(Node.js/Python 의존성 설치) 및 브라우저 환경 설정(Playwright 등)은 **[`./MCP/README.md`](./MCP/README.md)** 파일을 참고해 주세요.

### 설정 파일 준비 (필수)
- `./config/.gemini/settings.example.json` 파일을 복사하여 **`settings.json`**으로 이름을 바꾼 뒤, 본인의 github API Key, notion API Key를 입력하세요.(MCP 사용시 선택사항)

## 3. 프로젝트 구조 (Project Tree)

```text
./
├── node/                   # Node.js 포터블 런타임 (사용자 준비)
├── python/                 # Python 포터블 런타임 (사용자 준비)
├── cache/                  # 브라우저 바이너리 및 각종 캐시 (자동 생성)
├── config/                 # 설정 및 사용자 프로필 데이터
│   ├── .gemini/            # Gemini CLI 전용 설정 (GEMINI.md, settings.json 등)
│   ├── AppData/            # 샌드박스 격리용 앱 데이터 (브라우저 프로필 및 데이터 통합)
│   │   └── Local/ms-playwright/user_data  # 브라우저 통합 데이터 저장소
│   └── .gitconfig          # 로컬 Git 설정 파일
├── MCP/                    # Model Context Protocol 서버 모음
│   ├── README.md           # MCP 서버 설치 및 역할 가이드
│   ├── excel-mcp-server    # 엑셀 시트 읽기/쓰기 서버 (Python)
│   ├── github-server       # GitHub 연동 서버 (Node.js)
│   ├── Office-Word-MCP-Server # 워드 문서 제어 서버 (Python)
│   ├── Office-PowerPoint-MCP-Server # 파워포인트 제어 서버 (Python)
│   ├── PDFMathTranslate    # PDF 번역 및 수식 변환 서버 (Python)
│   └── playwright-MCP-Server # 브라우저 자동화 및 제어 서버 (Node.js)
├── WebApps/                # 포터블 브라우저 앱 실행기
│   ├── Gemini_Web.bat      # 포터블 Gemini 웹 페이지 실행
│   ├── Notion_portable.bat # 포터블 노션 웹 페이지 실행
│   └── Playwright_Chromium.bat # 포터블 크로미움 브라우저 실행 
├── node_modules/           # Gemini CLI 코어 및 종속성 (자동 생성)
├── start-gemini.bat        # 포터블 환경 실행 진입점 (CLI 자동 설치 포함)
├── start-portable-shell.bat # start-portable-shell.ps1 실행
├── start-portable-shell.ps1 # 포터블 런타임 환경의 PowerShell 셸 실행 파일(start-portable-shell.bat으로 실행할 것)
├── patch-sandbox.js        # 샌드박스 우회 런타임 패치 스크립트
├── package.json            # 프로젝트 의존성 및 메타데이터
├── .gitignore             # GitHub 업로드 제외 규칙 설정
└── README.md               # 현재 문서 (설명서)
```

## 4. 실행 방법

1. `node/`와 `python/` 폴더가 준비되었는지 확인합니다.
2. `config/.gemini/settings.json` 설정이 완료되었는지 확인합니다.
3. **`start-gemini.bat`** 파일을 실행합니다.
4. 최초 실행 시 CLI 코어가 없는 경우 자동으로 `npm install`을 진행한 뒤 구동됩니다.
-  CLI 실행 시 업데이트 문구가 뜨는 경우, **`start-portable-shell.bat`**을 실행하여 셸을 띄운 후, 프로젝트 루트 디렉터리에서 **npm install -g @google/gemini-cli** 를 입력하여 업데이트를 진행하세요. (자동 업데이트 안해줌)
- GEMINI에게 지침을 내려주고 싶은 경우, **./config/.gemini/GEMINI.md** 파일에 지침을 작성하세요.


## 5. 주의 사항
- **보안**: API 키가 포함된 `settings.json`과 `oauth_creds.json`은 절대 외부나 GitHub에 공유되지 않도록 주의하세요.
- **권한**: `patch-sandbox.js`는 파일 시스템 보호를 해제하므로, 신뢰할 수 있는 환경에서만 사용하시기 바랍니다.
- **로그인 흔적**: CLI 로그인 gemini API키로 로그인하거나, 브라우저를 열어서 로그인하면 **./config/.gemini/oauth_creds.json** 에 저장되며 외부 PC에 흔적을 남기지 않으니 안심할 수 있습니다. /WebApps/* 하위 bat 파일 실행 시 USB 내부 전용 브라우저를 사용하므로 로그인 흔적을 USB 내부 **./config/AppData/Local/ms-playwright/user_data** 에 저장합니다.