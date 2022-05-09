{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    spicetify.url = "/home/shebpamm/spicetify-nix";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, neovim-nightly, nixpkgs-f2k, spicetify, sops-nix }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; }; # Forgive me Mr. Stallman
      };

      overlays = [
        nixpkgs-f2k.overlay
        neovim-nightly.overlay
        spicetify.overlay
      ];
    in
    {
      homemanagerConfigurations = {
        kerosene = home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              home.stateVersion = "21.11";
              programs.home-manager.enable = true;
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
              imports = [
                ./modules/system/openrgb.nix
                ./modules/shell
                ./modules/editors/neovim.nix
                ./modules/editors/emacs.nix
                ./modules/editors/vim.nix
                ./modules/dev/lua.nix
                ./modules/dev/node.nix
                ./modules/dev/rust.nix
                ./modules/dev/nix.nix
                ./modules/dev/python.nix
                ./modules/programs
                ./modules/programs/graphics.nix
                ./modules/desktop
                ./modules/desktop/windowManagers/awesome.nix
                ./modules/desktop/windowManagers/berry.nix
                ./modules/desktop/windowManagers/herbstluftwm.nix
                ./modules/desktop/windowManagers/i3.nix
                ./modules/desktop/windowManagers/sway.nix
              ];
            };
          system = "x86_64-linux";
          homeDirectory = "/home/shebpamm";
          username = "shebpamm";
          stateVersion = "21.11";
        };

        ethylene = home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              home.stateVersion = "21.11";
              programs.home-manager.enable = true;
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
              imports = [
                ./modules/shell
                ./modules/editors/neovim.nix
                ./modules/editors/emacs.nix
                ./modules/editors/vim.nix
                ./modules/dev/lua.nix
                ./modules/dev/node.nix
                ./modules/dev/rust.nix
                ./modules/dev/nix.nix
                ./modules/dev/python.nix
                ./modules/programs
                ./modules/programs/graphics.nix
                ./modules/desktop
                ./modules/desktop/windowManagers/awesome.nix
              ];
            };
          system = "x86_64-linux";
          homeDirectory = "/home/shebpamm";
          username = "shebpamm";
          stateVersion = "21.11";
        };
      };
      nixosConfigurations = {
        kerosene = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
            ./hosts/kerosene/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
        ethylene = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
            ./hosts/ethylene/configuration.nix
          ];
        };
      };
    };
}
