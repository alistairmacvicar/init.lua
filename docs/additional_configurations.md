# Additional Configurations

This document covers various additional configurations and features in the Neovim setup.

## Color Scheme Configuration

- The default color scheme is set to "rose-pine".

To change the color scheme replace the returned value in `theme.lua`

## Git Integration (LazyGit)

The configuration uses LazyGit for Git integration within Neovim.

Keybinding:
- `<leader>lg`: Open LazyGit window

I'm not 100% sold on this yet but I think it'll be really cool when I learn all the keybindings.

## Quick File Navigation (Harpoon)

Harpoon is used for quick navigation between frequently used files.

Keybindings:
- `<leader>a`: Add current file to Harpoon
- `<C-t>`: Toggle Harpoon quick menu
- `<C-a>`: Navigate to 1st file in Harpoon list
- `<C-s>`: Navigate to 2nd file in Harpoon list
- `<C-d>`: Navigate to 3rd file in Harpoon list
- `<C-f>`: Navigate to 4th file in Harpoon list

Harpoon allows you to quickly switch between a set of marked files, greatly enhancing navigation in your projects.

## Fuzzy Finder (Telescope)

Telescope is used for fuzzy finding, providing quick access to files and content search.

Keybindings:
- `<leader>ff`: Find files in the current directory
- `<C-p>`: Find files tracked by Git
- `<leader>fs`: Search for a string in the current directory

Note that the string searching uses `Grep`, so if you're on Windows you'll need to disable or modify this in `nvim/after/plugin/telescope.lua`

## Syntax Highlighting (Treesitter)

Treesitter is used for advanced syntax highlighting and code parsing.

Configuration:
- Auto Installation: Treesitter will automatically install missing parsers when entering a buffer.
- Synchronous Installation: Parsers are not installed synchronously.
- Highlighting: Syntax highlighting is enabled for all supported languages.
- Additional Vim Regex Highlighting: Disabled to prevent potential slowdowns and duplicate highlights.

## Auto-formatting

The configuration uses Prettier for automatic code formatting on save. This applies to all file types (`*` pattern).

## Auto-pairing

Nvim-autopairs is used for automatic bracket and quote pairing. It's configured to work with various languages and frameworks, including HTML, JavaScript, TypeScript, and React.

## Auto-tags

Nvim-autotags is used to get vsc-style html tag completion

## Nvim-Surround

Really nice plugin to add/change/delete surrounding characters, I just use the default config

## Auto Directory Entry

When creating a directory in Netrw, navigate to it automatically after creation.
