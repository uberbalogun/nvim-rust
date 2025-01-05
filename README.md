# Neovim Configuration for Rust Development

A customized Neovim configuration based on NvChad, optimized for Rust development. This configuration provides enhanced features for Rust programming, including inlay hints, integrated terminal management, and efficient window navigation.

## Features

- Rust-focused development environment
- Inlay hints for better type information
- Integrated terminal management
- Based on NvChad for optimal performance
- Modern and clean interface
- Fast and lightweight
- Integrated with Cascade AI through Codeium

## Prerequisites

- Neovim (>= 0.9.0)
- Git
- Rust and cargo
- rust-analyzer

## Installation

1. Backup your existing Neovim configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. Clone this repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/nvim-rust.git ~/.config/nvim
   ```

3. Start Neovim:
   ```bash
   nvim
   ```
   The configuration will automatically install required plugins on first launch.

## Required Mason Plugins

After installation, you need to manually install the following plugins using Mason (`:Mason` command in Neovim):

1. `codelldb` - Debugger for Rust
2. `stylua` - Lua code formatter
3. `rust-analyzer` - Rust language server
4. `lua-language-server` - Lua language server

To install these plugins:
1. Open Neovim
2. Type `:Mason`
3. Press `i` on each of these plugins to install them
4. Wait for the installation to complete
5. Restart Neovim

Note: Make sure all these plugins are installed before using the configuration for the best development experience.

## Cascade AI Integration

This configuration includes Cascade AI integration through Codeium. To use it:

1. First-time setup:
   ```
   :Codeium Auth
   ```
   Follow the instructions to authenticate with your Codeium account.

2. Features:
   - AI-powered code completion with contextual understanding
   - Ergonomic, non-intrusive suggestions that appear as you type
   - Seamless integration with nvim-cmp
   - Specialized Rust support:
     - Smart type annotations and inference
     - Intelligent match pattern suggestions
     - Error handling with Result/Option types
     - Standard library function completions
     - Struct and trait implementation suggestions

3. Key bindings:
   - Suggestions appear automatically as you type
   - `Tab` or `Ctrl+y` - Accept suggestion
   - `Ctrl+n` and `Ctrl+p` - Navigate through suggestions
   - `Ctrl+e` - Dismiss suggestions

4. Benefits:
   - Works like a pair programmer, offering contextual completions
   - Maintains your coding flow without interruptions
   - Full control over suggestions - accept, modify, or reject
   - Integrates naturally with Neovim's completion workflow

## Custom Key Bindings

### Terminal Operations
- `<leader>i` - Open terminal in a new tab
- `<Esc>` - Exit terminal mode (when in terminal)
- `Ctrl+d` or type `exit` - Close terminal session

### Window Navigation
- `Ctrl+h` - Move to left window
- `Ctrl+j` - Move to window below
- `Ctrl+k` - Move to window above
- `Ctrl+l` - Move to right window

### Tab Navigation
- `gt` - Go to next tab
- `gT` - Go to previous tab
- `<number>gt` - Go to tab number <number> (e.g., `2gt` goes to second tab)

### Code Features
- `<leader>y` - Toggle inlay hints

Note: `<leader>` key is set to spacebar

## Rust-Specific Features

- Automatic rust-analyzer integration
- Inlay hints for:
  - Type hints
  - Parameter hints
  - Chaining hints
- Integrated debugging support
- Code completion
- Go to definition
- Find references
- Hover documentation

## Acknowledgments

- Based on [NvChad](https://github.com/NvChad/NvChad)
- Inspired by [LazyVim](https://github.com/LazyVim/starter)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
