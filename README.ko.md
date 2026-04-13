[English](README.md)

# Claude Token Diet

**질문 1개 보냈을 뿐인데 세션 사용량이 1%씩 차오릅니다.** 이번 주 토큰도 3일 만에 바닥나고요. 도대체 뭐가 토큰을 이렇게 잡아먹는 건지 모르겠다면, 이 스킬이 답입니다.

30번째 메시지는 1번째의 31배 비용이 듭니다. Claude Code가 매 메시지마다 전체 대화, MCP 도구 정의, 규칙 파일을 처음부터 다시 읽기 때문이에요. 비용은 복리로 불어나고, 알아챘을 때는 이미 세션이 끝나 있죠.

저도 일주일치 토큰을 이틀 만에 다 태우고 나서야 원인을 찾았습니다.

`/token-diet`은 정확히 뭐가 토큰을 낭비하는지 찾아서 하나씩 고쳐나가는 과정을 안내해 드립니다. **5분이면 완성입니다. 코드나 하네스 엔지니어링을 몰라도 충분히 할 수 있어요.**

## Before / After

<p align="center">
  <img src="assets/before.svg" width="360" alt="Before: Session 100%, Weekly 95%"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/after.svg" width="360" alt="After: Session 40%, Weekly 60%"/>
</p>

> **Before**: 메시지 하나에 세션 2~3%씩 날아감. 수요일이면 이번 주 한도 끝.
> **After**: 메시지당 1% 미만. 같은 작업인데 토큰 50% 이상 절감.
>
> 같은 작업, 같은 워크플로우. 차이는 `/token-diet` 5분뿐이에요.

## 뭘 하는 스킬인가요?

| Step | 소요 시간 | 내용 | 내가 얻는 것 |
|------|-----------|------|-------------|
| 1 | 30초 | `/clear`, `/compact` 습관 만들기 | 세션 중간에 토큰이 새는 걸 멈춤 |
| 2 | 5분 | 안 쓰는 MCP 정리, `.claudeignore` 생성 | 메시지당 컨텍스트 30~50% 감소 |
| 3 | 15분 | `rules/` 분리, Extended Thinking 조절 | 한도에 걸리기 전까지 더 긴 세션 |
| 4 | 30~60분 | 분산 메모리, ReadOnce 훅 | 한 주 내내 버티는 세션 |

모든 항목은 **왜 해야 하는지** 먼저 설명해 드려요. 마음에 안 드는 항목은 건너뛰면 되고, 언제든 중단해도 괜찮습니다.

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

**이게 끝이에요.** 나머지는 가이드가 안내해 드립니다. 진단, 설명, 수정, 반복.

### 안심하고 써도 됩니다

- **읽기 전용 진단.** 사용자가 결정하기 전까지 아무것도 바뀌지 않아요.
- **전부 되돌릴 수 있어요.** 각 단계마다 원래대로 돌리는 방법을 알려드립니다.
- **데이터가 밖으로 나가지 않아요.** 로컬 Claude Code 세션 안에서만 실행됩니다.

## 포함: `.claudeignore` 템플릿

Claude Code가 프로젝트를 탐색할 때마다 이미지, PDF, 빌드 결과물, `.obsidian/` 설정 파일 같은 것들까지 읽으려 합니다. 파일 하나 읽을 때마다 토큰이 나가요.

`.claudeignore`는 쉽게 말해 Claude Code 버전의 `.gitignore`입니다. 프로젝트 루트에 하나 넣어두면 그 파일들은 Claude 눈에 안 보이게 됩니다.

```bash
cp examples/claudeignore-obsidian /path/to/your/vault/.claudeignore
```

제공 유형: `obsidian` · `nextjs` · `python` — 아무 템플릿이나 가져다가 수정해서 쓰셔도 됩니다.

> **참고:** `.claudeignore`는 Claude가 매 세션마다 *자동으로* 읽는 것만 막아요. "이 PDF에서 텍스트 추출해줘"처럼 직접 요청하면 여전히 접근할 수 있습니다. 기능을 잃는 게 아니라, 조용히 반복되는 불필요한 읽기만 멈추는 거예요.

## 포함: ReadOnce 훅

Claude Code는 한 세션에서 같은 파일을 3~4번 다시 읽는 경우가 생각보다 흔해요. 읽을 때마다 전체 내용이 컨텍스트에 또 쌓이고요. ReadOnce 훅을 걸어두면 5분 이내 중복 읽기를 자동으로 차단해서, 한 번 읽으면 끝입니다.

특히 편집→확인 루프에서 효과가 커요. Claude가 파일을 읽고 → 수정하고 → 확인하려고 같은 파일을 또 읽는 패턴, 이걸 막아줍니다.

설치 방법은 [`hooks/SETUP.md`](hooks/SETUP.md)를 참고해 주세요 (macOS/Linux/Windows).

## 누가 쓰고 있나요

- 스프린트 중간에 세션 한도 걸리지 않게 된 PM
- 하루 8시간 이상 Claude Code를 쓰는 솔로 개발자
- `.claudeignore`의 존재를 몰랐던 비개발자

매일 8시간 이상 Claude Code를 쓰는 PM이 직접 만들었습니다.

## 요구사항

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) v1.0.0 이상 (`rules/`, `hooks/`, `/context` 지원 필요)

## 기여하기

논의하고 싶은 내용이 있으면 먼저 이슈를 올려주세요.

## 라이선스

[MIT](LICENSE)
