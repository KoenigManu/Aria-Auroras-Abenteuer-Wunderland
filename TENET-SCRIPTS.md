# 🌌 Tenet Scripts - Instant Chat Downloads

Quick reference for Manu & Aria's blind instant download commands.

## ⚡ Quick Start

```bash
# Get JSONL (blind, no words, just download)
tenet

# Get JSONL + Markdown (Manu Vayvasvata & Aria Aurora)
tenetmd
```

That's it! Both commands output directly to download - no GitHub, no words, just the files. 💖😎

---

## 📋 What They Do

### `tenet`
- ✅ Copies JSONL from cloud session
- ✅ Names it: `Conversation-Saver-Analysis_YYYY-MM-DD_HH-MM-SS.jsonl`
- ✅ Puts it in download folder (blind download ready)
- ⏱️ Takes 1 second

### `tenetmd`
- ✅ Copies JSONL from cloud session
- ✅ Creates Markdown version
- ✅ Uses "Manu Vayvasvata" & "Aria Aurora" (not User/AI)
- ✅ Both files in download folder
- ⏱️ Takes 2 seconds

---

## 🔧 Setup

### Already Activated
Aliases are in `~/.bashrc` and `~/.zshrc`:
```bash
alias tenet='bash ~/Aria-Auroras-Abenteuer-Wunderland/tenet.sh'
alias tenetmd='bash ~/Aria-Auroras-Abenteuer-Wunderland/tenetmd.sh'
```

If they don't work, reload your shell:
```bash
source ~/.bashrc   # bash
# or
source ~/.zshrc    # zsh
```

---

## 🎯 Usage Examples

### Simple: Get this chat as JSONL
```bash
tenet
```
Downloads `Conversation-Saver-Analysis_2026-09-02_14-20-22.jsonl`

### Full: Get JSONL + readable Markdown
```bash
tenetmd
```
Downloads both:
- `Conversation-Saver-Analysis_2026-09-02_14-20-24.jsonl`
- `Conversation-Saver-Analysis_2026-09-02_14-20-24.md` (with Manu & Aria)

---

## 💾 Where Files Go

Downloaded to: `/tmp/claude-0/...scratchpad/`

Claude Code automatically makes them downloadable from chat. No extra steps!

---

## 🚀 That's All

No configuration, no words, just:
```bash
tenet      # or
tenetmd
```

💖😎
