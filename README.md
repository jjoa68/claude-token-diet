[한국어](README.ko.md)

# Claude Token Diet

**One question = 1% of your session. Gone.** Your weekly quota burned through in 3 days. And you have no idea what's eating your tokens.

Claude Code silently re-reads everything — your entire conversation, every MCP tool definition, every rule file — on every single message. The cost compounds fast. By the time you notice, the session is already gone.

`/token-diet` finds exactly what's wasting your tokens and walks you through fixing it. **5 minutes. No code required.**

## Before / After

<p align="center">
  <img src="assets/before.svg" width="360" alt="Before: Session 100%, Weekly 95%"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/after.svg" width="360" alt="After: Session 40%, Weekly 60%"/>
</p>

> Same workflow, same tasks. The only difference: 5 minutes with `/token-diet`.

## Who needs this

- Anyone who's seen **"Session limit reached"** way too early
- **Non-developers** using Claude Code (PMs, marketers, writers) who hit usage limits and don't know why
- **Developers** who want to squeeze more out of every session

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
| 2 | 5min | High | Kill unused MCP tools, add `.claudeignore`, tighten CLAUDE.md |
| 3 | 15min | Med-High | Split `rules/`, tune Extended Thinking, MCP Tool Search |
| 4 | 30-60min | Medium | Distributed memory, prompt habits, ReadOnce hook |
| 1 | 30s | High | `/clear` and `/compact` habits for long-term savings |

Steps 2-4 change your environment — immediate, measurable results. Step 1 builds habits that keep those gains over time.

Every item explains **why** before asking you to act. Skip anything. Stop anytime.

## Bonus: `.claudeignore` templates

Every time Claude Code searches your project, it reads files it doesn't need — images, PDFs, build artifacts, `.obsidian/` configs. Each unnecessary file read costs tokens on every single tool call.

`.claudeignore` is like `.gitignore` for Claude Code. Drop one in your project root and those files are invisible to Claude forever.

```bash
cp examples/claudeignore-obsidian /path/to/your/vault/.claudeignore
```

Available: `obsidian` · `nextjs` · `python`

Don't see your stack? Use any template as a starting point and customize.

## Bonus: ReadOnce Hook

Claude Code often re-reads the same file 3-4 times in a single session — every re-read dumps the full content into your context again. The ReadOnce hook blocks duplicate reads within 5 minutes, so one read is enough.

This is especially useful during edit-verify loops where Claude reads → edits → reads the same file again to confirm.

See [`hooks/SETUP.md`](hooks/SETUP.md) for setup (macOS/Linux/Windows).

## Requirements

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) v1.0.0+ (needs `rules/`, `hooks/`, `/context` support)

## Contributing

Issues and PRs welcome. Open an issue first to discuss.

## License

[MIT](LICENSE)
