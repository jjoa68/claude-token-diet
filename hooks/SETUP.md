> TL;DR: ReadOnce 훅을 설치하면 같은 세션에서 동일 파일 중복 읽기를 자동 차단한다.
> macOS/Linux는 bash, Windows는 PowerShell 스크립트를 사용한다.
> 설치 후 settings.json에 PreToolUse 훅으로 등록해야 동작한다.

# ReadOnce 훅 설치 가이드

## 동작 원리

- Claude Code의 `Read` 도구 호출을 PreToolUse 훅으로 감시
- 같은 파일을 5분 이내에 다시 읽으려 하면 차단하고 "이미 읽었다"고 안내
- offset/limit이 지정된 분할 읽기는 허용 (대규모 편집 시 필요하므로)
- 캐시는 `/tmp/claude-read-cache-<uid>/`에 사용자별로 저장되며, 시스템 재부팅 시 초기화

---

## macOS / Linux 설치

### 1. 훅 파일 복사

```bash
# 훅 디렉토리 생성 (없으면)
mkdir -p ~/.claude/hooks

# 훅 파일 복사
cp hooks/readonce-hook.sh ~/.claude/hooks/readonce-hook.sh

# 실행 권한 부여
chmod +x ~/.claude/hooks/readonce-hook.sh
```

### 2. settings.json에 훅 등록

`~/.claude/settings.json` 파일을 열고 아래 내용을 추가한다.

파일이 없으면 새로 만든다. 이미 있으면 `hooks` 키 안에 `PreToolUse` 항목만 추가한다.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Read",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/readonce-hook.sh"
          }
        ]
      }
    ]
  }
}
```

기존 settings.json에 다른 설정이 있는 경우, `hooks` 키를 기존 객체에 병합한다.

> **⚠️ JSON 편집이 처음이라면**: 수정 전에 기존 파일을 백업하세요.
> ```bash
> cp ~/.claude/settings.json ~/.claude/settings.json.bak
> ```
> 편집 후 Claude Code가 실행되지 않으면 JSON 구문 오류일 가능성이 높습니다.
> 백업 파일로 복원하세요: `cp ~/.claude/settings.json.bak ~/.claude/settings.json`
> 
> 흔한 실수: 쉼표(`,`) 누락, 중괄호(`{}`) 불일치, 따옴표(`"`) 빠짐.

예시:

```json
{
  "permissions": {
    "allow": ["Read", "Write"]
  },
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Read",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/readonce-hook.sh"
          }
        ]
      }
    ]
  }
}
```

---

## Windows 설치

### 1. 훅 파일 복사

```powershell
# 훅 디렉토리 생성 (없으면)
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\hooks"

# PowerShell 훅 파일 복사
Copy-Item hooks\readonce-hook.ps1 "$env:USERPROFILE\.claude\hooks\readonce-hook.ps1"
```

### 2. settings.json에 훅 등록

`%USERPROFILE%\.claude\settings.json` 파일을 열고 아래 내용을 추가한다.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Read",
        "hooks": [
          {
            "type": "command",
            "command": "powershell -ExecutionPolicy Bypass -File \"%USERPROFILE%\\.claude\\hooks\\readonce-hook.ps1\""
          }
        ]
      }
    ]
  }
}
```

> Git Bash 또는 WSL이 설치된 환경에서는 bash 버전(`readonce-hook.sh`)을 사용해도 된다.

---

## 동작 확인

### 테스트 방법

1. Claude Code를 실행한다.
2. 아무 파일을 읽는다. (정상 동작)
3. 같은 파일을 다시 읽으려 한다.
4. "이 파일은 N초 전에 이미 읽었습니다. 컨텍스트의 기존 내용을 사용하세요" 메시지가 표시되면 정상.

### 캐시 초기화

5분 기다리지 않고 캐시를 즉시 초기화하고 싶다면:

```bash
# macOS / Linux
rm -rf /tmp/claude-read-cache-$(id -u)

# Windows (PowerShell)
Remove-Item -Recurse -Force "$env:TEMP\claude-read-cache-$env:USERNAME"
```

### 훅 비활성화

훅을 일시적으로 끄고 싶다면 settings.json에서 해당 훅 항목을 삭제하거나 주석 처리한다. (JSON은 주석을 지원하지 않으므로 항목 자체를 삭제해야 한다.)

---

## 주의사항

- 이 훅은 `Read` 도구만 감시한다. `Grep`, `Glob` 등 다른 도구에는 영향 없다.
- offset이 있는 분할 읽기(예: 큰 파일의 특정 구간만 읽기)는 차단하지 않는다.
- 캐시는 `/tmp/`에 사용자별로 저장되므로 시스템 재부팅 시 자동 초기화된다.
- bash 버전은 python3가 필요하다. (macOS 기본 포함, Linux 대부분 포함)
- Windows PowerShell 버전은 python3 없이 동작한다. (PowerShell 5.1 이상 필요, Windows 10 기본 포함)
