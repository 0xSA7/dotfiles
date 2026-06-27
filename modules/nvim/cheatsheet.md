# 0xSA7 IDE - The Ultimate Workflow Cheat Sheet

## 1. The Golden Rule of Vim
**COMMAND = OPERATOR + [NUMBER] + MOTION / TEXT OBJECT**
- **Operators**: `d` (delete), `c` (change), `y` (yank), `v` (select)
- **Motions**: `w` (word), `$` (end of line), `0` (start of line)
- **Text Objects**: `iw` (inner word), `i{` (inner brackets), `a{` (around brackets)

## 2. VS Code Equivalents (Quick Translation)
| VS Code | Neovim |
| :--- | :--- |
| `Ctrl + P` | `<Space> f f` (Find Files) |
| `Ctrl + Shift + F` | `<Space> f g` (Live Grep) |
| Go Back / Forward | `Ctrl + o` / `Ctrl + i` |
| Hover Docs | `K` (Normal Mode) |
| Explorer Sidebar | `Ctrl + n` (Neo-tree) |
| Integrated Terminal | `Ctrl + /` (Snacks Terminal) |

## 3. Dashboard, Terminal & Snacks
| Keybinding | Action |
| :--- | :--- |
| `f` / `n` / `c` | (Dashboard) Find File / New File / Config |
| `h` / `q` | (Dashboard) Open Cheat Sheet / Quit |
| `Ctrl + /` | Toggle Floating Terminal (`exit` to close) |
| `<Space> u n` | Dismiss all floating notifications |

## 4. Visual Mode (Selection)
| Keybinding | Action |
| :--- | :--- |
| `v` | Character selection |
| `V` | Line selection |
| `Ctrl + v` | Block/Column selection |
| `>` / `<` | Indent / Unindent selection |

## 5. Core Editing & Text Objects
| Keybinding | Action |
| :--- | :--- |
| `i` / `a` | Insert mode / Append |
| `o` / `O` | New line below / New line above |
| `dd` / `D` | Delete entire line / Delete to end of line |
| `ciw` / `diw` / `yiw`| Change / Delete / Copy word |
| `ci"` / `di"` | Change / Delete inside quotes |
| `ci{` / `di{` / `da{`| Change inside / Delete inside / Delete entire block |

## 6. Copy, Paste & Undo
| Keybinding | Action |
| :--- | :--- |
| `yy` | Copy (Yank) entire line |
| `p` / `P` | Paste after cursor / Paste before cursor |
| `"+yy` / `"+p` | Copy to / Paste from System Clipboard |
| `u` / `Ctrl + r` | Undo / Redo |

## 7. Search & Replace
| Keybinding | Action |
| :--- | :--- |
| `/text` / `?text` | Search forward / Search backward |
| `n` / `N` | Next / Previous match |
| `*` | Search word under cursor |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirmation |

## 8. Movement & File Navigation
| Keybinding | Action |
| :--- | :--- |
| `h` `j` `k` `l` | Left, Down, Up, Right |
| `w` / `b` | Next word / Previous word |
| `gg` / `G` | Top of file / Bottom of file |
| `Ctrl + d` / `Ctrl + u`| Jump down / up half a page |
| `gf` / `gx` | Open file under cursor / Open URL |
| `Ctrl + ]` | Jump to definition |

## 9. Buffers, Tabs & Window Management
| Keybinding | Action |
| :--- | :--- |
| `Shift + L` / `H` | Next Tab / Previous Tab (Bufferline) |
| `<Space> b d` | Close current Buffer safely |
| `Ctrl + w` + `v` / `s` | Vertical split / Horizontal split |
| `Ctrl + w` + `h/j/k/l`| Move between splits |
| `Ctrl + w` + `q` / `=` | Close split / Equalize split sizes |

## 10. Telescope (Fuzzy Search)
| Keybinding | Action |
| :--- | :--- |
| `<Space> f f` / `f g` | Find Files / Live Grep |
| `Ctrl + n` / `Ctrl + p`| (Inside Telescope) Next / Previous result |
| `:pwd` / `:cd <path>` | Show current search root / Change search root |

## 11. LSP, Autocompletion & AI
| Keybinding | Action |
| :--- | :--- |
| `Ctrl + Space` | Trigger completion menu |
| `K` | Hover over function for documentation |
| `<Space> m p` | Toggle Markdown Preview in Browser |
| `Ctrl + f` | (Supermaven) Accept entire AI suggestion |
| `Ctrl + j` | (Supermaven) Accept next word of AI suggestion |

## 12. Emergency Commands (Panic Button)
| Command | Action |
| :--- | :--- |
| `Esc` (x3) | Return to Normal Mode |
| `:noh` | Clear search highlights |
| `:q!` | Quit without saving |
| `:wq` | Save and quit |
