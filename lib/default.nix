{ inputs, ... }:
let
  inherit (inputs.nixpkgs) legacyPackages;
in
rec {
  # Plugin builder function
  mkVimPlugin =
    { system }:
    let
      inherit (pkgs) vimUtils;
      inherit (vimUtils) buildVimPlugin;
      pkgs = legacyPackages.${system};
    in
    buildVimPlugin {
      name = "user";
      postInstall = ''
        rm -rf $out/.envrc
        rm -rf $out/.gitignore
        rm -rf $out/LICENSE
        rm -rf $out/README.md
        rm -rf $out/flake.lock
        rm -rf $out/default.nix
        rm -rf $out/flake.nix
        rm -rf $out/justfile
      '';
      src = ../.;
    };

  # Core plugin list organized by functionality
  mkNeovimPlugins =
    { system }:
    let
      inherit (pkgs) vimPlugins;
      pkgs = legacyPackages.${system};
      user-nvim = mkVimPlugin { inherit system; };
    in
    [
      # Core functionality
      vimPlugins.plenary-nvim # Required by many plugins
      vimPlugins.which-key-nvim # Key binding helper
      vimPlugins.mini-nvim # Collection of minimal plugins
      vimPlugins.better-escape-nvim

      # LSP and Completion
      vimPlugins.nvim-lspconfig
      vimPlugins.luasnip
      vimPlugins.conform-nvim
      vimPlugins.lsp-format-nvim
      vimPlugins.typescript-tools-nvim
      vimPlugins.nvim-cmp
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-cmdline
      vimPlugins.cmp-path
      vimPlugins.cmp-buffer
      vimPlugins.lspkind-nvim

      # Navigation and Search
      vimPlugins.telescope-nvim
      vimPlugins.telescope-ui-select-nvim
      vimPlugins.telescope-file-browser-nvim
      vimPlugins.telescope-zf-native-nvim

      # Git Integration
      vimPlugins.gitsigns-nvim
      vimPlugins.vim-fugitive
      vimPlugins.lazygit-nvim

      # Syntax and Language Support
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-context
      vimPlugins.nvim-treesitter-textobjects
      vimPlugins.nvim-treesitter-parsers.c
      vimPlugins.nvim-treesitter-parsers.regex
      vimPlugins.nvim-treesitter-parsers.markdown
      vimPlugins.nvim-treesitter-parsers.markdown_inline
      vimPlugins.nvim-treesitter-parsers.css
      vimPlugins.nvim-treesitter-parsers.lua
      vimPlugins.nvim-treesitter-parsers.vim
      vimPlugins.nvim-treesitter-parsers.tsx
      vimPlugins.nvim-treesitter-parsers.javascript
      vimPlugins.nvim-treesitter-parsers.typescript
      vimPlugins.nvim-treesitter-parsers.go
      vimPlugins.nvim-treesitter-parsers.sql
      vimPlugins.nvim-treesitter-parsers.nix
      vimPlugins.nvim-treesitter-parsers.rust
      vimPlugins.nvim-treesitter-parsers.html
      vimPlugins.nvim-treesitter-parsers.bash
      vimPlugins.nvim-treesitter-parsers.templ
      vimPlugins.nvim-treesitter-parsers.python

      # UI and Aesthetics
      vimPlugins.catppuccin-nvim
      vimPlugins.lualine-nvim

      # Productivity Tools
      vimPlugins.undotree
      vimPlugins.orgmode
      vimPlugins.headlines-nvim

      # User config
      user-nvim
    ];

  # External tooling and language servers
  mkExtraPackages =
    { system }:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    [
      # Language Servers
      # pkgs.gopls
      # pkgs.htmx-lsp
      pkgs.lua-language-server
      pkgs.nil
      # pkgs.tailwindcss-language-server
      # pkgs.typescript-language-server
      # pkgs.vscode-langservers-extracted

      # Formatters and Linters
      pkgs.nixfmt-rfc-style
      # pkgs.nodePackages_latest.prettier
      # pkgs.prettierd
      pkgs.stylua

      # Tools
      # pkgs.python3
      pkgs.ripgrep
      # pkgs.templ
    ];

  mkExtraConfig = ''
    lua << EOF
      require("user")
      vim.cmd("set runtimepath+=./ftplugin")
    EOF
  '';

  # Neovim builder
  mkNeovim =
    { system }:
    let
      inherit (pkgs) lib neovim;
      extraPackages = mkExtraPackages { inherit system; };
      pkgs = legacyPackages.${system};
      start = mkNeovimPlugins { inherit system; };
    in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = {
          inherit start;
        };
      };
      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
    };

  # Home Manager integration
  mkHomeManager =
    { system }:
    let
      extraConfig = mkExtraConfig;
      extraPackages = mkExtraPackages { inherit system; };
      plugins = mkNeovimPlugins { inherit system; };
    in
    {
      inherit extraConfig extraPackages plugins;
      defaultEditor = true;
      enable = true;
    };
}
