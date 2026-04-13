[한국어](README.ko.md)

# Claude Token Diet

**One question = 1% of your session. Gone.** Your weekly quota burned through in 3 days. And you have no idea what's eating your tokens.

Your 30th message costs 31x the first one. Claude Code silently re-reads everything — your entire conversation, every MCP tool definition, every rule file — on every single message. The cost compounds fast. By the time you notice, the session is already gone.

I burned through a week's quota in 2 days before I figured out what was happening.

`/token-diet` finds exactly what's wasting your tokens and walks you through fixing it. **30 minutes. No code required.**

## Before / After

<p align="center">
  <img src="assets/before.svg" width="360" alt="Before: Session 100%, Weekly 95%"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/after.svg" width="360" alt="After: Session 40%, Weekly 60%"/>
</p>

> **Before**: Each message eats 2–3% of your session. Weekly limit gone by Wednesday.
> **After**: Under 1% per message. Same workflow, 50%+ fewer tokens burned.
>
> Same tasks. The only difference: 30 minutes with `/token-diet`.

## What it does

| Step | Time | What | You get |
|------|------|------|---------|
| 1 | 30s | `/clear` and `/compact` habits | Stop bleeding tokens mid-session |
| 2 | 5min | Kill unused MCPs, add `.claudeignore` | 30–50% less context per message |
| 3 | 15min | Split `rules/`, tune Extended Thinking | Longer sessions before hitting limits |
| 4 | 30–60min | Distributed memory, ReadOnce hook | Sessions that last all week |

Every step explains **why** before asking you to act. Skip anything. Stop anytime.

## Quick Start

```bash
# 1. Clone
git clone https://github.com/jjoa68/claude-token-diet.git
cd claude-token-diet

# 2. Install
mkdir -p ~/.claude/commands
cp commands/token-diet.md ~/.claude/commands/token-diet.md

# 3. Run (in any Claude Code session)
/token-diet
```

**That's it.** The guide does the rest — diagnose, explain, fix, repeat.

### Safe to try

- **Read-only diagnostic.** Nothing changes until you decide.
- **Undo everything.** Each step tells you how to revert.
- **No data leaves your machine.** Runs entirely in your local Claude Code session.

## Included: `.claudeignore` templates

Claude reads every file it finds — images, PDFs, lockfiles, `.obsidian/` configs. Each unnecessary read costs tokens on every single tool call.

Drop a `.claudeignore` in your project root and those files become invisible to Claude. Think `.gitignore`, but for token savings.

```bash
cp examples/claudeignore-obsidian /path/to/your/vault/.claudeignore
```

Templates: `obsidian` · `nextjs` · `python` — or use any as a starting point.

> **Note:** `.claudeignore` only stops *automatic* reads. When you explicitly ask Claude to work with an ignored file (e.g. "extract text from this PDF"), it can still access it. You're not losing capability — just stopping the silent, repeated reads that waste tokens.

## Included: ReadOnce Hook

Claude re-reads the same file 3–4 times in a single session. Every re-read dumps the full content into your context again. ReadOnce blocks duplicate reads within 5 minutes — one read is enough.

Especially useful during edit-verify loops where Claude reads → edits → reads the same file again to confirm.

See [`hooks/SETUP.md`](hooks/SETUP.md) for setup (macOS/Linux/Windows).

## Who's using this

- PMs who stopped hitting session limits mid-sprint
- Solo developers running Claude Code 8+ hours a day
- Non-technical users who didn't know `.claudeignore` existed

Built by a PM who uses Claude Code 8+ hours daily.

## Requirements

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) v1.0.0+ (needs `rules/`, `hooks/`, `/context` support)

## Contributing

Issues and PRs welcome. Open an issue first to discuss.

## License

[MIT](LICENSE)
