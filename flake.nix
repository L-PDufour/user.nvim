{
  description = "This is my nvim flake, which gets installed via nix";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ {flake-parts, ...}:
      flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        lib = import ./lib {inherit inputs;};
      }; 
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: let
        nvimPlugin = pkgs.vimUtils.buildVimPlugin {
          name = "user-nvim";
          postInstall = ''
            rm -rf $out/README.md
            rm -rf $out/flake.lock
            rm -rf $out/flake.nix
          '';
          src = ./.;
        };
        customNeovim = pkgs.neovim.override {
          configure = {
            packages.myPlugins = with pkgs.vimPlugins; {
              start = [ nvimPlugin ];
            };
          };
          devShells = {
            default = mkShell { buildInputs = [ just ]; };
          };
          formatter = alejandra;
          packages = {
            default = self.lib.mkVimPlugin { inherit system; };
            neovim = self.lib.mkNeovim { inherit system; };
          };
        };
      in {
        formatter = pkgs.alejandra;
        packages = {
          default = nvimPlugin;
          neovim = customNeovim;
        };
        apps = {
          neovim = {
            type = "app";
            program = "${customNeovim}/bin/nvim";
          };
        };
      };
    };
}
