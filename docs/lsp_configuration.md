# Language Server Protocol (LSP) Configuration

I'm using nvim 0.11's vim.lsp to configure everything, and just use Mason to handle the installation of servers.

## Autocompletion (nvim-cmp)

Autocompletion is provided by nvim-cmp and is set up with the following keybindings:

- `<C-p>`: Select previous item
- `<C-n>`: Select next item
- `<C-y>`: Confirm selection
- `<C-Space>`: Complete
- `<Tab>`: Confirm selection if completion menu is visible, otherwise insert tab

Autocompletion sources include LSP, buffer, and file path.

## LSP Keybindings

The following keybindings are set up for LSP functionality:

- `gd`: Go to definition
- `K`: Hover information
- `<leader>vws`: Workspace symbol search
- `<leader>d`: Open diagnostic float
- `[d`: Go to next diagnostic
- `]d`: Go to previous diagnostic
- `<leader>vca`: Code action
- `<leader>gr`: References
- `<leader>r`: Rename
- `<C-h>` (in insert mode): Signature help

## Customization

All configs are in `config/lsp/` on a server-by-server basis
