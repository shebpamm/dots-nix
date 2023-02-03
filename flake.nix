{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-2111.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k/3322009946e80d441d5156d41a6ef22742708efd";
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
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-2111, home-manager, neovim-nightly, nixpkgs-f2k, spicetify, sops-nix, work-nix, nomachine, logiops, hyprland, hyprpaper, nur, devenv }:
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
        nixpkgs-f2k.overlays.default
        neovim-nightly.overlay
        hyprpaper.overlays.default
        (self: super: { nomachine = nomachine-pkgs.nomachine; })
        (self: super: { keepassxc-stable = stable-pkgs.keepassxc; })
        (self: super: { devenv = devenv.packages.${system}.devenv; })
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
                  name = "experimental-anticonceal-implementation-20130.patch";
                  url = "https://gist.githubusercontent.com/shebpamm/12e98dfa99973b40254fcffe29b752fa/raw/1adacca492e7fdc8e61818eaba60a485ef710d96/20130.patch";
                  sha256 = "sha256-OsMuJh16NCl/F6XwZP2JaAcC6cLaxJPy+W+iyEvdJYQ=";
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
            ./modules/programs/wayland.nix
            ./modules/programs/graphics.nix
            ./modules/desktop
            ./modules/desktop/windowManagers/awesome.nix
            ./modules/desktop/windowManagers/hyprland.nix
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
            ./modules/shell
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
            ./modules/programs/xorg.nix
            ./modules/programs/work.nix
            ./modules/desktop
            ./modules/desktop/windowManagers/awesome.nix
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
      };
    };
}
