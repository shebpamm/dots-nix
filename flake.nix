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

  outputs = inputs @ { self, nixpkgs, nixpkgs-2111, nixpkgs-master, home-manager, neovim-nightly, nixpkgs-f2k, spicetify, sops-nix, work-nix, nomachine, logiops, hyprland, hyprpaper, nur, devenv }:
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
        neovim-nightly.overlay
        hyprpaper.overlays.default
        (self: super: { nomachine = nomachine-pkgs.nomachine; })
        (self: super: { keepassxc-stable = stable-pkgs.keepassxc; })
        (self: super: { devenv = devenv.packages.${system}.devenv; })
        (self: super: { linuxPackages_bleeding = master-pkgs.linuxPackages_latest; })
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
                  url = "https://gist.githubusercontent.com/shebpamm/280b5cfa8236d04ddee31c957b9f8cb7/raw/fa9cd21eef2ef7a8cb45c2122001fc7ebaee2fe3/anticonceal-feb.patch";
                  sha256 = "sha256-L2F0h52sIqIs77CYXvqHN8KXjpWDkGH93t2DT5iI4ak=";
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
