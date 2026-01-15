# Configs

## Neovim

### Plugins
- akinsho/bufferline.nvim
- folke/tokyonight.nvim                # colorscheme
- kylechui/nvim-surround               # surround motions
- lewis6991/gitsigns.nvim              # Git plugin
- neovim/nvim-lspconfig                # lspconfig for autocompletion
- nvimdev/dashboard-nvim               # Dashboard like vim-startify
- nvim-lualine/lualine.nvim            # lualine as an equivalent for airline
- nvim-tree/nvim-tree.lua              # filebrowser
- nvim-tree/nvim-web-devicons          # nerdfonts and icons for nvim-tree
- nvim-treesitter/nvim-treesitter      # Treesitter
- nvim-telescope/telescope.nvim        # fuzzy finding
- MeanderingProgrammer/render-markdown.nvim
- windwp/nvim-autopairs                # auto pairs

### Needed packages

Needs the following packages:
- rustup (Blink.cmp and Telescope)
- cargo (Telescope)
- ripgrep (for Telescope)
- rust-analyzer (`rustup component add rust-analyzer` or Package Manager)

Nerdfont is required
- Set it in Terminal Emulator like Alacritty or Terminal on Windows
- Set it in init.lua for nvim


## Installation

1. Download a [Nerdfont](https://nerdfonts.com)
2. Set the NerdFont for your Terminal-Emulator e.g. in alacritty under [font] `normal = { family = "FiraCode Nerd Font", style = "Regular" }`]
3. Install the necessary packages

**Caution**: Don't open neovim, untio everything else is installed

**Caution 2**: Make sure you use the latest neovim version... no problem on Arch/Rolling Release, otherwise use the snap/flatpak version

```
sudo pacman -S rustup cargo ripgrep neovim
rustup default stable
rustup component add rust-analyzer 
```

## Keys and Keybindings
### Keys
#### Basics
Basic vim movements to get started
```
j - down
k - up
h - left
l - right
i - insert Mode
A - insert mode at the EOL
Esc - normal mode
v - visual mode
yy - yank (copy) line
3yy - yank this line + 2 lines => yank 3 lines
dd - cut current line
3dd - delete three lines
p - paste line (register 0)
dw - delete next word
d2w - delete next 2 words
db - delete last word
d2b - delete last 2 words
d$ - delete until EOL
```

#### Advanced
Visual Mode
```
v - enter char-wise visual mode
V - line-wise visual mode
Ctrl + v - block-wise visual mode
j/k - select whole lines
> move indentation to the right
< move indentation to the left
```

Buffers
```
:bn - Next Buffer
:bp - Previous Buffer
:bd - Delete Current Buffer
:bd! - Force Delete Current Buffer
```

Registers
```
"2p - Yank text from second register
```

Tabs
```
:tabnew foo.txt
gt - next tab
gT - Previous tab
```

Recordings
```
qr - Start Recording for Register r
q - Stop Recording
@r - do recorded actions

```

Stuff
```
"+yy - copy to system clipboard (maybe * instead of +)
:%sort - sort whole file, also possible by selection in visual mode
:%sort! - reverse sort
:%s/Pattern/pattern/g - search and replace
```


### Keybindings
| Key | Action |
| --- | --- |
| Leader | ö |
| Leader + n | disable highlighting after search (:noh) |
| Leader + w | Save file without quitting |
| Leader + W | Show trailing whitespaces | 
| Leader + e | toggle nvim-tree |
| Leader + t | Terminal | 
| Leader + gb | Git blame |
| Leader + gd | Git diff |
| Leader + gts | Git toggle signs |
| Leader + rm | Render Markdown/Disable Render |
| Leader + ff | Fuzzy finder |
| Leader + fg | Fuzzy finder  live grep |
| Leader + b | Next Buffer |
| Leader + B | Previous Buffer |
| Leader + db | Delete current Buffer |
| Leader + [1-9] | Go to buffer number [1-9] |
| ysiw" | Surround -> Add " around the current word |
| ds" | Surround -> Delete " around the current word |
| cs'" | Surround -> Change ' to  " around the current word |
| Leader + a | Toggle fold under cursor |
| Leader + o | Open all folds |
| Leader + c | Close all folds |



