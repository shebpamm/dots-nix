{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-2111.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay/167ec1a6047ef9051c709e4115fb5f4f90c5febd";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    spicetify.url = "github:shebpamm/spicetify-nix";
    sops-nix.url = "github:Mic92/sops-nix";
    work-nix.url = "/home/shebpamm/work-nix";
    nomachine.url = "github:rytec-nl/nixpkgs/submit/add-nomachine-server";
    logiops.url = "github:ckiee/nixpkgs/logiops-nixos";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-2111, home-manager, neovim-nightly, nixpkgs-f2k, spicetify, sops-nix, work-nix, nomachine, logiops }:
    let
      system = "x86_64-linux";

      nomachine-pkgs = import nomachine {
        inherit system;
        config = { allowUnfree = true; }; # Forgive me Mr. Stallman
      };

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; }; # Forgive me Mr. Stallman
      };

      stable-pkgs = import nixpkgs-2111 {
        inherit system;
        config = { allowUnfree = true; }; # Forgive me Mr. Stallman
      };

      logiops-pkgs = import logiops { inherit system; };

      overlays = [
        nixpkgs-f2k.overlay
        neovim-nightly.overlay
        spicetify.overlay
        (self: super: { nomachine = nomachine-pkgs.nomachine; })
        (self: super: { keepassxc-stable = stable-pkgs.keepassxc; })
        (self: super: { formats = logiops-pkgs.formats; })
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
                ./modules/shell/ssh.nix
                ./modules/editors/neovim.nix
                ./modules/editors/emacs.nix
                ./modules/editors/vim.nix
                ./modules/dev/lua.nix
                ./modules/dev/node.nix
                ./modules/dev/rust.nix
                ./modules/dev/nix.nix
                ./modules/dev/python.nix
                ./modules/dev/docker.nix
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
                ./modules/programs/work.nix
                ./modules/desktop
                ./modules/desktop/windowManagers/awesome.nix
                work-nix.homeManagerConfiguration
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
            "${nomachine.outPath}/nixos/modules/services/admin/nomachine.nix"
            "${logiops.outPath}/nixos/modules/hardware/logiops"
            work-nix.nixosModule
          ];
        };
      };
    };
}
