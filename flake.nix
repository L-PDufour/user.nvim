{
  description = "Neovim configuration for TheAltF4Stream as a plugin";

  inputs = {
    copilotchat = {
      flake = false;
      url = "github:CopilotC-Nvim/CopilotChat.nvim?ref=canary";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      debug = true;

      flake = {
        lib = import ./lib {inherit inputs;};
      };

      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: let
        inherit (pkgs) alejandra just mkShell;
      in {
        apps = {
          nvim = {
            program = "${config.packages.neovim}/bin/nvim";
            type = "app";
          };
        };

        devShells = {
          default = mkShell {
            buildInputs = [just];
          };
        };

        formatter = alejandra;

        packages = {
          default = self.lib.mkVimPlugin {inherit system;};
          neovim = self.lib.mkNeovim {inherit system;};
        };
      };
    };
}
