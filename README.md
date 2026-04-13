[한국어](README.ko.md)

# Claude Token Diet

**Your 30th message costs 31x the first one.** Most people don't know why.

Claude Code re-reads the entire conversation every single message. Your MCP tools, rules, and ignored files silently inflate the bill. By the time you notice, the session is gone.

`/token-diet` finds the waste and walks you through fixing it. **5 minutes. No code required.**

## Before / After

<p align="center">
  <img src="assets/before.svg" width="360" alt="Before: Session 100%, Weekly 95%"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/after.svg" width="360" alt="After: Session 40%, Weekly 60%"/>
</p>

> Same workflow, same tasks. The only difference: 5 minutes with `/token-diet`.

## Who needs this

- **Non-developers** using Claude Code (PMs, marketers, writers) who hit usage limits and don't know why
- **Developers** who want to squeeze more out of every session
- Anyone who's seen "Session limit reached" way too early

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

## What it does (step by step)

| Step | Time | Impact | What |
|------|------|--------|------|
| 1 | 30s | High | `/clear` and `/compact` — the habits that save the most |
| 2 | 5min | High | Kill unused MCP tools, add `.claudeignore`, tighten CLAUDE.md |
| 3 | 15min | Med-High | Split `rules/`, tune Extended Thinking, MCP Tool Search |
| 4 | 30-60min | Medium | Distributed memory, prompt habits, ReadOnce hook |

Every item explains **why** before asking you to act. Skip anything. Stop anytime.

## Bonus: `.claudeignore` templates

Drop-in templates for common project types:

```bash
cp examples/claudeignore-obsidian /path/to/your/vault/.claudeignore
```

Available: `obsidian` · `nextjs` · `python`

## Bonus: ReadOnce Hook

Blocks Claude Code from re-reading the same file within 5 minutes. Prevents duplicate content from eating your context.

See [`hooks/SETUP.md`](hooks/SETUP.md) for setup.

## Requirements

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) v1.0.0+ (needs `rules/`, `hooks/`, `/context` support)

## Contributing

Issues and PRs welcome. Open an issue first to discuss.

## License

[MIT](LICENSE)
