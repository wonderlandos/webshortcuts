# Web Shortcuts

Search a website from Search: type `!`, a keyword and what to look for, then Enter. `!aw pacman hooks` opens the Arch
Wiki's search, `!w Lisbon` Wikipedia, `!gh wolos` GitHub. Type `!` alone, or the start of a keyword, for the list.

| Keyword | Site | Keyword | Site |
|---|---|---|---|
| `w` | Wikipedia | `rs` | Rust crates (crates.io) |
| `wt` | Wiktionary | `so` | Stack Overflow |
| `aw` | Arch Wiki | `yt` | YouTube |
| `ap` | Arch packages | `osm` | OpenStreetMap |
| `gh` | GitHub | `ddg` | DuckDuckGo |
| `mdn` | MDN Web Docs | `man` | manual pages (man.archlinux.org) |

- **Asks for:** `open` (Open apps, files and links): the address goes to your default browser. The plugin reads nothing
  from the web and keeps nothing you type.
- **Files:** `plugin.toml`, `search.lua` (a `[[search]]` command entry, prefix `!`), `icon.png`, `preview.webp`.

## Install

From the Store: **Plugins**, then **Get** on Web Shortcuts. From a release: `wol plugin add wonderlandos.webshortcuts-1.0.wolplug --yes` (a file the index did not sign is marked
unreviewed), then `wol plugin enable wonderlandos.webshortcuts`.

## Tests

`.tests/case-*.json` are runs of the scripts in the WolOS plugin runtime (wol-lua, the shell's sandbox and Lua API) with
fixture answers for `wol.run`: nothing on the machine runs. Each case lists the steps (render, popover, click, change,
query) and the text the result must and must not contain; the runner (`plugtest`, wol-lua with fixture services) is
not published yet. `wol plugin check` on a copy of the folder named after the id is the lint.

## Release

`.github/workflows/hub-release.yml` turns a pushed tag `v<plugin.toml version>` (`v1.0`) into a GitHub release with
`wonderlandos.webshortcuts-<version>.wolplug`, checked by the hub's own hubcheck first (wonderlandos/hub `wol-release.yml`, pinned).

Licence: GPL-2.0-or-later.
