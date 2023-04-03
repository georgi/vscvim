# Neovim Configuration

This Neovim configuration uses the Lazy.nvim plugin manager to load and manage the following plugins:

- **flit.nvim**: A plugin for quick cursor movement across text.
- **leap.nvim**: A plugin for quickly jumping to characters.
- **nvim-surround**: A plugin for dealing with surrounding characters like parentheses, brackets, etc.
- **mini.comment**: A minimalist commenting plugin.
- **nvim-treesitter**: A collection of plugins for syntax highlighting, indentation, and more.
  - *nvim-treesitter-textobjects*: A dependency of nvim-treesitter that provides text objects based on syntax trees.
- **mini.ai**: A plugin that provides better text objects.

## Key Bindings

| Key    | Mode | Description             |
|--------|------|-------------------------|
| f, F   | n, x, o | Flit.nvim key bindings |
| t, T   | n, x, o | Flit.nvim key bindings |
| s      | n, x, o | Leap forward to        |
| S      | n, x, o | Leap backward to       |
| gs     | n, x, o | Leap from windows      |
| <C-j>  |      | Incremental selection   |
| <bs>   |      | Decremental selection   |


## Plugin Configuration

Each plugin can be customized by modifying its configuration within the `require("lazy").setup({ ... })` call. Refer to each plugin's documentation for available options and usage instructions.

- **flit.nvim**: [GitHub Repository](https://github.com/ggandor/flit.nvim)
- **leap.nvim**: [GitHub Repository](https://github.com/ggandor/leap.nvim)
- **nvim-surround**: [GitHub Repository](https://github.com/kylechui/nvim-surround)
- **mini.comment**: [GitHub Repository](https://github.com/echasnovski/mini.comment)
- **nvim-treesitter**: [GitHub Repository](https://github.com/nvim-treesitter/nvim-treesitter)
- **mini.ai**: [GitHub Repository](https://github.com/echasnovski/mini.ai)
