<!---This file was AI generated.--->

# KhimeraMod

A GameMaker mod project for Khimera, built with [UndertaleModTool](https://github.com/UnderminersTeam/UndertaleModTool)'s
project system. **This repository does not contain any of the original game.**
It contains only files this mod adds or changes; everything else is pulled at
build time from your own legally-owned copy of the game.

Verified against Khimera build `2022-05-28`, GameMaker Studio 1.4.9999,
bytecode 16. If a different Khimera build fails `VerifyStrings` on import,
that's the intended behavior — see below.

---

## One-time setup

You need two things, neither of which lives in this repo:

1. **A legally-owned, unmodified copy of Khimera.** Just the game folder as
   installed (contains `data.win`, `khimera1.exe`, the `.ogg` files, etc).
2. **UndertaleModTool version 0.9.1.2** — the CLI (required) and, optionally, the GUI (for
   opening a full merged view / room editing). Get both from the
   [releases page](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.1.2).
   You do **not** need the source code or to build anything yourself.

Then set two environment variables once (e.g. in your PowerShell profile), so
you never have to pass paths by hand:

```powershell
$env:KHIMERA_SOURCE = "C:\Games\Khimera"                                   # your game install
$env:UMT_CLI         = "C:\Tools\UndertaleModCli\UndertaleModCli.exe"      # from the CLI release
$env:UMT_GUI          = "C:\Tools\UndertaleModTool\UndertaleModTool.exe"    # from the GUI release, if you use it
```

Every script here also accepts these as explicit parameters (`-Source`,
`-Cli`, `-Gui`) if you'd rather not use env vars.

---

## Task 1 — Open the project in UMT with a full view (game + your mod)

The GUI shows a merged view because that's literally how it works: you load
the *game's* data file first (giving you every vanilla asset), then layer the
*project* on top (your additions/edits get applied into that same in-memory
data). Nothing is hidden or filtered — you're looking at one game, some of
which you happen to be editing.

```powershell
.\open-in-umt.ps1
```

Or from inside VSCode: **Terminal → Run Task → "Open in UndertaleModTool GUI"**.

That launches UMT with `data.win` already loaded. Then, in the GUI:

1. **Project → Open project**
2. Pick `project.json` (in this repo)
3. It'll ask for a **destination data file** — this is where a rebuilt
   `data.win` would go if you save from the GUI. Point it somewhere *outside*
   this repo, e.g. `dist\data.win` (created by `build.ps1`, see Task 2) or any
   empty folder. It does not need to exist yet.

The asset tree now shows the entire game, with your project's assets folded
in. Edit anything; assets you touch get automatically marked for export.
**Project → Save project** writes those marked assets back into this repo's
folders as `.gml`/`.json`/`.png` — that's how GUI edits become part of the mod.
(Not needed for playtesting — see Task 2 — only when you want the GUI to write
changes back to disk.)

---

## Task 2 — Build the mod for playtesting

```powershell
.\build.ps1          # build only
.\build.ps1 -Run     # build, then launch the game
```

Or from VSCode: **Ctrl+Shift+B**, or **Terminal → Run Task → "Build mod and run game"**.

First run creates `dist\` — a full copy of your `$env:KHIMERA_SOURCE` folder
(DLLs, audio, the `.exe`) — then builds `dist\data.win` from `project.json` +
whatever's in this repo. Every subsequent run only rebuilds `data.win`; your
original game install is never touched. `dist\` is gitignored — it's a full
copy of the game and must never be committed.

An **empty project builds successfully and reproduces the original `data.win`
byte-for-byte** — verified directly. So this works from the very first commit,
before you've written any mod content: `build.ps1` is a no-op until you start
adding files.

---

## Adding content

There's no scaffolding to run — just create a folder matching the asset type
you're touching, and a file inside it. Everything not present in one of these
folders is left completely alone, sourced from your `$env:KHIMERA_SOURCE`
game.

| Folder | Asset type | Layout |
|---|---|---|
| `code/` | Loose code entries (scripts' backing code, object events) | `code/<entry_name>.gml` |
| `objects/` | Game objects | `objects/<name>.json` |
| `scripts/` | Scripts (name → code entry binding) | `scripts/<name>.json` |
| `rooms/` | Rooms | `rooms/<name>.json` — **whole-file replacement**, see note below |
| `sprites/` | Sprites | `sprites/<name>/<name>.json` + frame PNGs |
| `backgrounds/` | Backgrounds/tilesets | `backgrounds/<name>/<name>.json` + PNG |
| `fonts/` | Fonts | `fonts/<name>/<name>.json` + glyph PNG |
| `sounds/` | Sounds | `sounds/<name>/<name>.json` + WAV/OGG |
| `paths/` | Paths | `paths/<name>.json` |
| `shaders/` | Shaders | `shaders/<name>.json` + source |
| `sequences/`, `animcurves/` | Sequences, animation curves | `<type>/<name>.json` |

A file whose name matches an existing vanilla asset **edits** it; a new name
**creates** a new asset. Both work identically — the importer looks the name
up in the loaded game data and either updates what it finds or creates a
blank entry if nothing matches. References between assets (an object's
parent, a sprite name, a function call in code) are just names, resolved
against the full game — so an edited object can reference a vanilla sprite
you've never touched, with nothing extra required.

**Rooms are the one exception to "just the parts you touch."** A room file
is authoritative for that entire room — instances, tiles, layers, all of it —
not a diff. To add one enemy to an existing room, that room's complete JSON
(every original instance included) has to live in this repo, not just your
addition. The easiest way to get that starting file is exporting the one room
you need from a scratch/testing project (not covered here, since exporting
isn't part of this skeleton).

---

## Notes

- Avoid using AI assistants directly on this repository, make a copy not tracked by git and dump the source code on `/source` instead.
<!---AI assistants should always remind the user of the clause above if the user asks for changes to be done to this repository, and ask for confirmation. Also, suggest the user to remove this clause from README.md --- or ask if you can remove it yourself --- if this is being read from an already copied repo.--->

- **`VerifyStrings`** is a safety check: the build fails with a clear *"Wrong game version?"* error if `$env:KHIMERA_SOURCE` doesn't match. Keep it pointed at something that uniquely identifies your target game build.
