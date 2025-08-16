# GEMINI.md

## Project Overview

This is a personal Neovim configuration for Ricardo Dias. It is a highly customized setup that uses `lazy.nvim` for plugin management and has a modular structure that separates core settings, plugin configurations, and LSP configurations. The configuration is tailored for web development (HTML, CSS, JavaScript, TypeScript, Angular), Lua, Python, and other languages.

## Building and Running

This is a Neovim configuration, so there is no traditional "build" process. To use this configuration, you need to have Neovim installed and clone this repository to `~/.config/nvim`.

When you open Neovim for the first time after cloning the repository, `lazy.nvim` will automatically install all the configured plugins.

## Development Conventions

The configuration is well-structured and modular.

*   **Core Settings:** Core Neovim settings are located in `lua/rdias/core/init.lua`.
*   **Plugin Management:** `lazy.nvim` is used for plugin management. The main configuration is in `lua/rdias/lazy.lua`.
*   **Plugin Configuration:** Plugin configurations are located in `lua/rdias/plugins/`. Each plugin has its own configuration file.
*   **LSP Configuration:** LSP configurations are located in `lua/rdias/plugins/lsp/`. Each language server has its own configuration file.

The configuration uses a variety of popular and powerful plugins, including:

*   **Telescope:** For fuzzy finding files, buffers, and more.
*   **nvim-treesitter:** For syntax highlighting and code parsing.
*   **lualine:** For a custom status line.
*   **nvim-tree:** For a file explorer.
*   **Copilot:** For AI-powered code completion.
*   **nvim-lspconfig:** For configuring language servers.
*   **nvim-cmp:** For autocompletion.
*   **DAP:** For debugging.

The configuration is also set up for a variety of languages, including:

*   HTML
*   CSS
*   JavaScript
*   TypeScript
*   Angular
*   Lua
*   Python
*   Terraform
*   GraphQL
*   JSON
*   YAML
*   Docker

The configuration also includes some custom keymaps for common tasks, such as window management and running Telescope commands.
