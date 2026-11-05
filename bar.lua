-- SPDX-License-Identifier: GPL-2.0-or-later
-- Menu bar item: a magnifier. The popover has one text field and a row per site; a row's Search
-- button opens the site's search for the words (or the site itself when the field is empty)
-- through wol.open (permission "open"). The words are kept in memory only.
local SITES = {
  { "Wikipedia", "https://en.wikipedia.org/w/index.php?search=", "https://en.wikipedia.org/" },
  { "Wiktionary", "https://en.wiktionary.org/w/index.php?search=", "https://en.wiktionary.org/" },
  { "Arch Wiki", "https://wiki.archlinux.org/index.php?search=", "https://wiki.archlinux.org/" },
  { "Arch packages", "https://archlinux.org/packages/?q=", "https://archlinux.org/packages/" },
  { "GitHub", "https://github.com/search?q=", "https://github.com/" },
  { "MDN Web Docs", "https://developer.mozilla.org/search?q=", "https://developer.mozilla.org/" },
  { "Rust crates", "https://crates.io/search?q=", "https://crates.io/" },
  { "Stack Overflow", "https://stackoverflow.com/search?q=", "https://stackoverflow.com/" },
  { "YouTube", "https://www.youtube.com/results?search_query=", "https://www.youtube.com/" },
  { "OpenStreetMap", "https://www.openstreetmap.org/search?query=", "https://www.openstreetmap.org/" },
  { "DuckDuckGo", "https://duckduckgo.com/?q=", "https://duckduckgo.com/" },
  { "Manual pages", "https://man.archlinux.org/search?q=", "https://man.archlinux.org/" },
}

local words = ""
local err = nil

-- Percent-encodes everything but the unreserved characters (RFC 3986); spaces become %20.
local function encode(s)
  return (s:gsub("[^%w%-%._~]", function(c) return string.format("%%%02X", c:byte()) end))
end

local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

local function address(site)
  local w = trim(words)
  if w == "" then return site[3] end
  return site[2] .. encode(w)
end

return wol.menubar {
  refresh = 0,
  render = function()
    return wol.image { "system-search-symbolic", size = 16 }
  end,
  popover = function()
    local rows = {}
    local w = trim(words)
    for _, site in ipairs(SITES) do
      rows[#rows + 1] = wol.item { title = site[1],
        subtitle = w == "" and site[3]:gsub("^https://", ""):gsub("/$", "") or ("Search for \"" .. w .. "\""),
        icon = "web-browser-symbolic",
        button = { label = w == "" and "Open" or "Search", on_click = function()
          local ok, e = wol.open(address(site))
          err = (not ok) and e or nil
        end } }
    end
    return wol.stack { spacing = 8,
      wol.label { "Web Shortcuts", role = "title" },
      wol.text_field { text = words, placeholder = "What to look for", on_change = function(t) words = t end },
      wol.label { err or "Then press Search next to the site.", role = "secondary" },
      wol.list(rows),
    }
  end,
}
