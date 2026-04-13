[English](README.md)

# Claude Token Diet

**질문 1개에 세션 사용량 1%씩 찹니다.** 이번 주 토큰도 3일 만에 다 써버립니다. 도대체 뭐가 토큰을 잡아먹는지 모르겠다면, 이 스킬을 써야 합니다.

30번째 메시지는 1번째의 31배 비용이 듭니다. Claude Code는 매 메시지마다 전체 대화, 모든 MCP 도구 정의, 모든 규칙 파일을 처음부터 다시 읽습니다. 비용은 복리로 불어납니다. 알아챘을 때는 이미 세션이 끝나 있습니다.

`/token-diet`은 정확히 뭐가 토큰을 낭비하는지 찾아서 고치는 과정을 안내합니다. **5분이면 됩니다. 코드 몰라도 됩니다.**

## Before / After

<p align="center">
  <img src="assets/before.svg" width="360" alt="Before: Session 100%, Weekly 95%"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/after.svg" width="360" alt="After: Session 40%, Weekly 60%"/>
</p>

> 같은 작업, 같은 워크플로우. 차이는 `/token-diet` 5분뿐.

## 이런 사람이 써야 한다

- **"Session limit reached"**를 너무 일찍 만나본 분
- Claude Code 쓰는 **비개발자** (PM, 마케터, 기획자) — 사용량 한도에 걸리는데 원인을 모르는 분
- 세션을 더 오래 쓰고 싶은 **개발자**

## 설치 & 실행

```bash
# 1. 클론
git clone https://github.com/jjoa68/claude-token-diet.git
cd claude-token-diet

# 2. 설치
mkdir -p ~/.claude/commands
cp commands/token-diet.md ~/.claude/commands/token-diet.md

# 3. 실행 (아무 Claude Code 세션에서)
/token-diet
```

**끝입니다.** 가이드가 알아서 안내합니다 — 진단, 설명, 수정, 반복.

## 뭘 하는 스킬인가 (단계별)

| Step | 소요 시간 | 효과 | 내용 |
|------|-----------|------|------|
| 1 | 30초 | 상 | `/clear`, `/compact` — 가장 많이 아끼는 습관 |
| 2 | 5분 | 상 | 안 쓰는 MCP 도구 정리, `.claudeignore` 생성, CLAUDE.md 강화 |
| 3 | 15분 | 중~상 | `rules/` 분리, Extended Thinking 조절, MCP Tool Search |
| 4 | 30~60분 | 중 | 분산 메모리, 프롬프트 습관, ReadOnce 훅 |

모든 항목은 **왜 해야 하는지** 먼저 설명합니다. 아무 항목이나 건너뛸 수 있고, 언제든 중단 가능합니다.

## 부록: `.claudeignore` 템플릿

Claude Code가 프로젝트를 탐색할 때마다 불필요한 파일까지 읽습니다 — 이미지, PDF, 빌드 결과물, `.obsidian/` 설정 파일. 파일 하나 읽을 때마다 토큰이 소비됩니다.

`.claudeignore`는 Claude Code 버전의 `.gitignore`입니다. 프로젝트 루트에 하나 넣으면 그 파일들은 Claude에게 영원히 안 보입니다.

```bash
cp examples/claudeignore-obsidian /path/to/your/vault/.claudeignore
```

제공 유형: `obsidian` · `nextjs` · `python`

내 스택이 없다면? 아무 템플릿이나 복사해서 커스터마이즈하면 됩니다.

> **참고:** `.claudeignore`는 Claude가 매 세션마다 *자동으로* 읽는 것만 막습니다. 직접 요청하면(예: "이 PDF에서 텍스트 추출해줘", "이 이미지를 변환해줘") 여전히 접근할 수 있습니다. 기능을 잃는 게 아니라, 조용히 반복되는 불필요한 읽기만 멈추는 겁니다.

## 부록: ReadOnce 훅

Claude Code는 한 세션에서 같은 파일을 3~4번 다시 읽는 경우가 흔합니다 — 읽을 때마다 전체 내용이 컨텍스트에 또 쌓입니다. ReadOnce 훅은 5분 이내 중복 읽기를 차단해서, 한 번 읽으면 끝입니다.

특히 편집→확인 루프에서 효과가 큽니다. Claude가 파일을 읽고 → 수정하고 → 확인하려고 같은 파일을 또 읽는 패턴을 차단합니다.

설치 방법은 [`hooks/SETUP.md`](hooks/SETUP.md) 참고 (macOS/Linux/Windows).

## 요구사항

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) v1.0.0 이상 (`rules/`, `hooks/`, `/context` 지원 필요)

## 기여하기

이슈와 PR을 환영합니다. 변경하고 싶은 내용이 있으면 먼저 이슈를 열어 주세요.

## 라이선스

[MIT](LICENSE)
