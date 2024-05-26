{inputs, ...}: let
  inherit (inputs.nixpkgs) legacyPackages;
in rec {
  mkVimPlugin = {system}: let
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
      src = ./.;
    };
  mkNeovimPlugins = {system}: let
    inherit (pkgs) vimPlugins;
    pkgs = legacyPackages.${system};
    user-nvim = mkVimPlugin {inherit system;};
  in [
    # Essential language support
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-cmp
    vimPlugins.luasnip
    vimPlugins.cmp-nvim-lsp

    # Fuzzy finding
    vimPlugins.plenary-nvim
    vimPlugins.telescope-nvim

    # Theme
    vimPlugins.tokyonight-nvim

    # Git integration
    vimPlugins.gitsigns-nvim

    # Treesitter for better syntax highlighting
    vimPlugins.nvim-treesitter.withAllGrammars

    # Icons
    vimPlugins.nvim-web-devicons

    # File explorer
    vimPlugins.nvim-tree-lua
    user-nvim
  ];

  mkExtraPackages = {system}: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in [
    pkgs.gopls
    pkgs.ripgrep
  ];

  mkExtraConfig = ''
    lua << EOF
      require("user").init()
    EOF
  '';

  mkNeovim = {system}: let
    inherit (pkgs) lib neovim;
    extraPackages = mkExtraPackages {inherit system;};
    pkgs = legacyPackages.${system};
    start = mkNeovimPlugins {inherit system;};
  in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = {inherit start;};
      };
      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };

  # You can keep this if you want to use it with home-manager
  mkHomeManager = {system}: {
    programs.neovim = {
      enable = true;
      extraConfig = mkExtraConfig;
      extraPackages = mkExtraPackages {inherit system;};
      plugins = mkNeovimPlugins {inherit system;};
    };
  };
}
