[한국어](README.ko.md)

# Claude Token Diet

A step-by-step interactive guide that helps you diagnose and reduce Claude Code token usage. Designed for non-developers too.

<!-- screenshot -->

## What It Does

Claude Code re-reads the entire conversation every message. By the 30th message, you're paying 31x the cost of the first.

`/token-diet` scans your environment, finds the waste, and walks you through fixing it — one item at a time, with full control over what gets changed.

**Nothing runs automatically.** Every change requires your confirmation.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) v1.0.0 or later (requires `rules/`, `hooks/`, `/context` support)

## Installation

### 1. Clone this repository

```bash
git clone https://github.com/ayoungjo/claude-token-diet.git
cd claude-token-diet
```

### 2. Copy the command file

```bash
# Create commands directory (if it doesn't exist)
mkdir -p ~/.claude/commands

# Copy the skill
cp commands/token-diet.md ~/.claude/commands/token-diet.md
```

### 2. Run it

In any Claude Code session:

```
/token-diet
```

## What It Covers

| Step | Time | Impact | What |
|------|------|--------|------|
| 1 | 30s | High | `/clear` and `/compact` habits |
| 2 | 5min | High | MCP cleanup, `.claudeignore`, CLAUDE.md rules |
| 3 | 15min | Medium-High | `rules/` separation, Extended Thinking, MCP Tool Search |
| 4 | 30-60min | Medium | Distributed memory, prompt habits, ReadOnce hook |

Each step explains **why** before asking you to act. You can skip any item or stop at any point.

## Examples

The `examples/` directory contains `.claudeignore` templates for common project types:

- `claudeignore-obsidian` — Obsidian vaults
- `claudeignore-nextjs` — Next.js projects
- `claudeignore-python` — Python projects

Copy the one that matches your project:

```bash
cp examples/claudeignore-obsidian /path/to/your/vault/.claudeignore
```

## ReadOnce Hook (Optional)

The ReadOnce hook blocks Claude Code from re-reading the same file within 5 minutes. This prevents duplicate content from inflating your context.

See [`hooks/SETUP.md`](hooks/SETUP.md) for installation instructions.

## How It Works

1. **Measure** — You run `/context` to capture your current token usage
2. **Diagnose** — The skill scans your environment and grades each area (pass/warning/fail)
3. **Guide** — Each item explains what it does, why it matters, and what happens if you skip it
4. **Apply** — You choose what to apply. Before/After numbers show the effect
5. **Report** — A summary shows everything you did and the estimated savings

## Contributing

Issues and pull requests are welcome. Please open an issue first to discuss what you'd like to change.

## License

[MIT](LICENSE)
