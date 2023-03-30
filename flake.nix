{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-2111.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k/3322009946e80d441d5156d41a6ef22742708efd";
    nixpkgs-sheb.url = "github:shebpamm/nixpkgs-sheb";
    nixpkgs-sheb.inputs.nixpkgs.follows = "nixpkgs";
    spicetify.url = "github:the-argus/spicetify-nix";
    sops-nix.url = "github:Mic92/sops-nix";
    work-nix.url = "/home/shebpamm/work-nix";
    nomachine.url = "github:rytec-nl/nixpkgs/submit/add-nomachine-server";
    logiops.url = "github:ckiee/nixpkgs/logiops-nixos";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper.url = "github:shebpamm/hyprpaper";
    hyprpaper.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-2111, nixpkgs-master, home-manager, neovim-nightly, nixpkgs-f2k, nixpkgs-sheb, spicetify, sops-nix, work-nix, nomachine, logiops, hyprland, hyprpaper, nur, devenv, disko }:
    let
      system = "x86_64-linux";

      unfreeImport = pkgs: import pkgs {
        inherit system;
        config = { allowUnfree = true; }; # Forgive me Mr. Stallman
      };

      nomachine-pkgs = unfreeImport nomachine;
      pkgs = unfreeImport nixpkgs;
      stable-pkgs = unfreeImport nixpkgs-2111;
      master-pkgs = unfreeImport nixpkgs-master;
      logiops-pkgs = unfreeImport logiops;

      overlays = [
        nixpkgs-f2k.overlays.default
        nixpkgs-sheb.overlay
        neovim-nightly.overlay
        hyprpaper.overlays.default
        (self: super: { nomachine = nomachine-pkgs.nomachine; })
        (self: super: { keepassxc-stable = stable-pkgs.keepassxc; })
        (self: super: { devenv = devenv.packages.${system}.devenv; })
        (self: super: { nixopsUnstable = master-pkgs.nixopsUnstable; })
        (self: super: { formats = logiops-pkgs.formats; })
        (self: super: {
          nur = import nur {
            nurpkgs = super;
            pkgs = super;
          };
        })
        (self: super: {
          neovim-nightly-anticonceal = super.neovim-nightly.overrideAttrs (_: {
            patches = [
              (super.pkgs.fetchpatch
                {
                  name = "experimental-anticonceal-implementation.patch";
                  url = "https://gist.githubusercontent.com/shebpamm/5eaa7a43ba6fa5eca6075af67f2d6b60/raw/02cb5d386df2a3b350d50a1a5cacfbf9a11d9a46/anticonceal.patch";
                  sha256 = "sha256-1TSYd9Im0Xnb0WE3nJJxOqHjQBHrL622dTBq16Jlzrs=";
                })
            ];
            # patches = [super.fetchpatch {} ];
          });
        })
      ];
    in
    {
      homemanagerConfigurations = {
        kerosene = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            {
              home = {
                homeDirectory = "/home/shebpamm";
                username = "shebpamm";
                stateVersion = "22.11";
              };

              nixpkgs.overlays = overlays;
              programs.home-manager.enable = true;
            }

            ./hm/system/openrgb.nix
            ./hm/system/gpg.nix
            ./hm/shell
            ./hm/shell/ssh.nix
            ./hm/editors/neovim.nix
            ./hm/editors/vim.nix
            ./hm/dev
            ./hm/programs
            ./hm/programs/xorg.nix
            ./hm/programs/graphics.nix
            ./hm/desktop
            ./hm/desktop/windowManagers/awesome.nix
            ./hm/desktop/windowManagers/hyprland.nix
          ];
        };

        ethylene = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            {
              home = {
                homeDirectory = "/home/shebpamm";
                username = "shebpamm";
                stateVersion = "22.11";
              };

              nixpkgs.overlays = overlays;
              programs.home-manager.enable = true;
            }
            ./hm/shell
            ./hm/editors/neovim.nix
            ./hm/editors/vim.nix
            ./hm/dev
            ./hm/programs
            ./hm/programs/graphics.nix
            ./hm/programs/xorg.nix
            ./hm/programs/work.nix
            ./hm/desktop
            ./hm/desktop/windowManagers/awesome.nix
            work-nix.homeManagerConfiguration
          ];
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
          ];
          specialArgs = { inherit inputs; };
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
          specialArgs = { inherit inputs; };
        };
        hexane = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
            ./hosts/hexane/configuration.nix
            disko.nixosModules.disko
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
