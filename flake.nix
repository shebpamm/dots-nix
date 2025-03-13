{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k/3322009946e80d441d5156d41a6ef22742708efd";
    nixpkgs-sheb.url = "github:shebpamm/nixpkgs-sheb";
    nixpkgs-sheb.inputs.nixpkgs.follows = "nixpkgs";
    spicetify.url = "github:the-argus/spicetify-nix";
    sops-nix.url = "github:Mic92/sops-nix";
    logiops.url = "github:ckiee/nixpkgs/logiops-nixos";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper.url = "github:shebpamm/hyprpaper";
    hyprpaper.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    devenv.url = "github:cachix/devenv";
    # devenv.inputs.nixpkgs.follows = "nixpkgs"; -- some gc breaks
    disko.url = "github:nix-community/disko";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    kmonad.url = "github:kmonad/kmonad?dir=nix";
    compfy.url = "github:allusive-dev/compfy";
    flox.url = "github:flox/flox";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      context = {
        system = system;
        mainUser = "shebpamm";
      };

      unfreeImport = pkgs: import pkgs {
        inherit system;
        config = { allowUnfree = true; }; # Forgive me Mr. Stallman
      };

      pkgs = unfreeImport nixpkgs;
      master-pkgs = unfreeImport inputs.nixpkgs-master;
      logiops-pkgs = unfreeImport inputs.logiops;

      overlays = [
        inputs.nixpkgs-f2k.overlays.default
        inputs.nixpkgs-sheb.overlay
        inputs.neovim-nightly.overlays.default
        inputs.hyprpaper.overlays.default
        (self: super: {
          flox = inputs.flox.packages.${system}.flox;
          compfy = inputs.compfy.packages.${system}.compfy;
          devenv = inputs.devenv.packages.${system}.devenv;
          formats = logiops-pkgs.formats;
          nixMaster = master-pkgs.nix;
          nur = import inputs.nur {
            nurpkgs = super;
            pkgs = super;
          };
          act-latest = master-pkgs.act;
        })
      ];
    in
    {
      homemanagerConfigurations = {
        kerosene = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs context; };
          modules = [
            {
              home = {
                homeDirectory = "/home/${context.mainUser}";
                username = context.mainUser;
                stateVersion = "23.11";
              };

              nixpkgs.overlays = overlays;
              programs.home-manager.enable = true;
            }

            ./hm/system/openrgb.nix
            ./hm/system/clipcat.nix
            ./hm/shell
            ./hm/shell/ssh.nix
            ./hm/editors/neovim.nix
            ./hm/editors/vscode.nix
            ./hm/editors/vim.nix
            ./hm/dev
            ./hm/programs
            ./hm/programs/xorg.nix
            ./hm/programs/graphics.nix
            ./hm/desktop
            ./hm/desktop/windowManagers/awesome.nix
            # ./hm/desktop/windowManagers/hyprland.nix
          ];
        };

        hexane = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs context; };
          modules = [
            rec {
              home = {
                homeDirectory = "/home/${context.mainUser}";
                username = context.mainUser;
                stateVersion = "23.11";
              };

              nixpkgs.overlays = overlays;
              programs.home-manager.enable = true;

              programs.ssh.matchBlocks."*".extraOptions = { IdentityAgent = "~/.1password/agent.sock"; };
              home.sessionVariables.SSH_AUTH_SOCK = "${home.homeDirectory}/.1password/agent.sock";
            }
            ./hm/desktop
            ./hm/desktop/windowManagers/awesome.nix
            ./hm/dev
            ./hm/editors/neovim.nix
            ./hm/editors/vim.nix
            ./hm/editors/vscode.nix
            ./hm/system/clipcat.nix
            ./hm/programs
            ./hm/programs/graphics.nix
            ./hm/programs/xorg.nix
            ./hm/programs/work.nix
            ./hm/shell
          ];
        };

        ethylene = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs context; };
          modules = [
            {
              home = {
                homeDirectory = "/home/${context.mainUser}";
                username = context.mainUser;
                stateVersion = "23.11";
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
            inputs.disko.nixosModules.disko
          ];
          specialArgs = { inherit inputs context; };
        };
        ethylene = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
            ./hosts/ethylene/configuration.nix
            "${inputs.logiops.outPath}/nixos/modules/hardware/logiops"
          ];
          specialArgs = { inherit inputs context; };
        };
        hexane = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
            ./hosts/hexane/configuration.nix
            inputs.disko.nixosModules.disko
          ];
          specialArgs = { inherit inputs context; };
        };
      };
    };
}
