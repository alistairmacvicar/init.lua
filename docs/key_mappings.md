# Key Mappings

The configuration uses the space key as the leader key.

## Normal Mode
- `<leader>pv`: Open file explorer in the current file's directory
- `J`: Join lines while keeping the cursor in place
- `<C-j>`: Scroll down half a page, keeping cursor centered
- `<C-k>`: Scroll up half a page, keeping cursor centered
- `n`: Search next occurrence, center view on match
- `<leader>y`: Yank to system clipboard
- `<leader>Y`: Yank whole line to system clipboard
- `Q`: Disabled (no operation)
- `<C-f>`: Open tmux sessionizer in a new tmux window 
- `<leader>s`: Find and replace current word under cursor
- `<leader>e`: Open floating diagnostic window for LSP warnings

## Insert Mode
- `<C-BS>`: Delete previous word (equivalent to <C-W>)

## Visual Mode
- `J`: Move selected block down
- `K`: Move selected block up
- `<leader>p`: Paste over selected text without changing copy buffer
- `<leader>y`: Yank selection to system clipboard

## Visual and Normal Mode
- `<leader>y`: Yank to system clipboard

## Harpoon
- `<leader>a`: Add current file to Harpoon
- `<C-t>`: Toggle Harpoon quick menu
- `<C-a>`: Navigate to 1st file in Harpoon list
- `<C-s>`: Navigate to 2nd file in Harpoon list
- `<C-d>`: Navigate to 3rd file in Harpoon list
- `<C-f>`: Navigate to 4th file in Harpoon list

## Telescope
- `<leader>ff`: Find files in the current directory
- `<C-p>`: Find files tracked by Git
- `<leader>fs`: Search for a string in the current directory

## LSP
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

## Autocompletion (nvim-cmp)
- `<C-p>`: Select previous item
- `<C-n>`: Select next item
- `<C-y>`: Confirm selection
- `<C-Space>`: Complete
- `<Tab>`: Confirm selection if completion menu is visible, otherwise insert tab
