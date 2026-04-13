[English](README.md)

# Claude Token Diet

Claude Code 토큰 사용량을 진단하고 단계별로 줄여주는 대화형 가이드. 비개발자도 사용할 수 있다.

<!-- screenshot -->

## 뭘 하는 스킬인가

Claude Code는 매 메시지마다 전체 대화를 처음부터 다시 읽는다. 30번째 메시지는 1번째의 31배 비용이 든다.

`/token-diet`은 환경을 스캔하고 낭비를 찾아서, 하나씩 고쳐나가도록 안내한다. 모든 변경은 사용자가 직접 선택한다.

**자동으로 실행되는 것은 없다.** 모든 변경은 확인을 받은 후에만 실행된다.

## 요구사항

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) v1.0.0 이상 (`rules/`, `hooks/`, `/context` 지원 필요)

## 설치

### 1. 레포 클론

```bash
git clone https://github.com/jjoa68/claude-token-diet.git
cd claude-token-diet
```

### 2. 커맨드 파일 복사

```bash
# 커맨드 디렉토리 생성 (없으면)
mkdir -p ~/.claude/commands

# 스킬 복사
cp commands/token-diet.md ~/.claude/commands/token-diet.md
```

### 2. 실행

Claude Code 세션에서:

```
/token-diet
```

## 다루는 내용

| Step | 소요 시간 | 효과 | 내용 |
|------|-----------|------|------|
| 1 | 30초 | 상 | `/clear`, `/compact` 습관 |
| 2 | 5분 | 상 | MCP 정리, `.claudeignore` 생성, CLAUDE.md 규칙 |
| 3 | 15분 | 중~상 | `rules/` 분리, Extended Thinking, MCP Tool Search |
| 4 | 30~60분 | 중 | 분산 메모리, 프롬프트 습관, ReadOnce 훅 |

각 Step은 **왜 해야 하는지** 먼저 설명한 후 적용 여부를 묻는다. 어느 항목이든 건너뛸 수 있고, 언제든 중단할 수 있다.

## 예시 파일

`examples/` 디렉토리에 프로젝트 유형별 `.claudeignore` 템플릿이 있다:

- `claudeignore-obsidian` — Obsidian 볼트용
- `claudeignore-nextjs` — Next.js 프로젝트용
- `claudeignore-python` — Python 프로젝트용

자기 프로젝트에 맞는 파일을 복사해서 사용한다:

```bash
cp examples/claudeignore-obsidian /path/to/your/vault/.claudeignore
```

## ReadOnce 훅 (선택)

ReadOnce 훅은 5분 이내에 같은 파일을 다시 읽는 것을 자동 차단한다. 동일 내용이 컨텍스트에 중복 적재되는 것을 막는다.

설치 방법은 [`hooks/SETUP.md`](hooks/SETUP.md)를 참고한다.

## 작동 방식

1. **측정** — `/context`를 실행해서 현재 토큰 사용량을 기록한다
2. **진단** — 환경을 스캔하고 각 영역을 판정한다 (양호/주의/미설정)
3. **안내** — 각 항목이 무엇인지, 왜 필요한지, 안 하면 어떻게 되는지 설명한다
4. **적용** — 사용자가 선택한 항목만 적용한다. Before/After 수치로 효과를 확인한다
5. **리포트** — 적용한 항목과 예상 절감 효과를 요약한다

## 기여하기

이슈와 PR을 환영한다. 변경하고 싶은 내용이 있으면 먼저 이슈를 열어 논의해 주세요.

## 라이선스

[MIT](LICENSE)
