[English](README.md)

# Claude Token Diet

**질문 1개에 세션 사용량 1%씩 찬다.** 이번 주 토큰도 3일 만에 다 써버린다. 도대체 뭐가 토큰을 잡아먹는지 모르겠다면, 이 스킬을 써야 한다.

Claude Code는 매 메시지마다 전체 대화, 모든 MCP 도구 정의, 모든 규칙 파일을 처음부터 다시 읽는다. 비용은 복리로 불어난다. 알아챘을 때는 이미 세션이 끝나 있다.

`/token-diet`은 정확히 뭐가 토큰을 낭비하는지 찾아서 고치는 과정을 안내한다. **5분이면 된다. 코드 몰라도 된다.**

## Before / After

<p align="center">
  <img src="assets/before.svg" width="360" alt="Before: Session 100%, Weekly 95%"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/after.svg" width="360" alt="After: Session 40%, Weekly 60%"/>
</p>

> 같은 작업, 같은 워크플로우. 차이는 `/token-diet` 5분뿐.

## 이런 사람이 써야 한다

- **"Session limit reached"**를 너무 일찍 만나본 사람
- Claude Code 쓰는 **비개발자** (PM, 마케터, 기획자) — 사용량 한도에 걸리는데 원인을 모르는 사람
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

**끝.** 가이드가 알아서 안내한다 — 진단, 설명, 수정, 반복.

## 뭘 하는 스킬인가 (단계별)

| Step | 소요 시간 | 효과 | 내용 |
|------|-----------|------|------|
| 2 | 5분 | 상 | 안 쓰는 MCP 도구 정리, `.claudeignore` 생성, CLAUDE.md 강화 |
| 3 | 15분 | 중~상 | `rules/` 분리, Extended Thinking 조절, MCP Tool Search |
| 4 | 30~60분 | 중 | 분산 메모리, 프롬프트 습관, ReadOnce 훅 |
| 1 | 30초 | 상 | `/clear`, `/compact` 습관 — 장기적 절감 효과 |

Step 2~4는 환경을 바꾼다 — 즉시 측정 가능한 결과. Step 1은 그 효과를 장기적으로 유지하는 습관.

모든 항목은 **왜 해야 하는지** 먼저 설명한다. 아무 항목이나 건너뛸 수 있고, 언제든 중단 가능.

## 부록: `.claudeignore` 템플릿

Claude Code가 프로젝트를 탐색할 때마다 불필요한 파일까지 읽는다 — 이미지, PDF, 빌드 결과물, `.obsidian/` 설정 파일. 파일 하나 읽을 때마다 토큰이 소비된다.

`.claudeignore`는 Claude Code 버전의 `.gitignore`다. 프로젝트 루트에 하나 넣으면 그 파일들은 Claude에게 영원히 안 보인다.

```bash
cp examples/claudeignore-obsidian /path/to/your/vault/.claudeignore
```

제공 유형: `obsidian` · `nextjs` · `python`

내 스택이 없다면? 아무 템플릿이나 복사해서 커스터마이즈하면 된다.

## 부록: ReadOnce 훅

Claude Code는 한 세션에서 같은 파일을 3~4번 다시 읽는 경우가 흔하다 — 읽을 때마다 전체 내용이 컨텍스트에 또 쌓인다. ReadOnce 훅은 5분 이내 중복 읽기를 차단해서, 한 번 읽으면 끝.

특히 편집→확인 루프에서 효과가 크다. Claude가 파일을 읽고 → 수정하고 → 확인하려고 같은 파일을 또 읽는 패턴을 차단한다.

설치 방법은 [`hooks/SETUP.md`](hooks/SETUP.md) 참고 (macOS/Linux/Windows).

## 요구사항

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) v1.0.0 이상 (`rules/`, `hooks/`, `/context` 지원 필요)

## 기여하기

이슈와 PR 환영. 변경하고 싶은 내용이 있으면 먼저 이슈를 열어 주세요.

## 라이선스

[MIT](LICENSE)
