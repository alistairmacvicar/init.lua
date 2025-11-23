# Neovim Settings

This configuration includes various settings to Neovim editing experience closer to a regular IDEE. Here's a breakdown of the key settings:

## Editor Appearance
- Line numbers are enabled with relative numbering
- Color scheme uses terminal GUI colors
- An 80-character column is displayed
- Scroll offset is set to 8 lines
- Sign column is always visible

## Indentation and Formatting
- Tabs are set to 2 spaces
- Smart indentation is enabled
- Text wrapping is disabled

## Search
- Incremental search is enabled
- Search highlight is disabled

## File Management
- Swap files are disabled
- Backups are disabled
- Persistent undo is enabled

## Performance
- Update time is set to 50ms for faster response

## Netrw (File Explorer)
- Relative line numbering is enabled in Netrw

## Miscellaneous
- Space is set as the leader key
- The `@` symbol is appended to the filename characters

## Automatic Behaviors

### Auto-formatting
- The configuration uses Conform to automatically format files on save.
- Each filetype that I use has a different formatter.
