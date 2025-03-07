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
    nomachine.url = "github:rytec-nl/nixpkgs/submit/add-nomachine-server";
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

  outputs = inputs @ { self, nixpkgs, nixpkgs-master, home-manager, neovim-nightly, nixpkgs-f2k, nixpkgs-sheb, spicetify, sops-nix, nomachine, logiops, hyprland, hyprpaper, nur, devenv, disko, flake-utils-plus, kmonad, compfy, flox }:
    let
      system = "x86_64-linux";

      unfreeImport = pkgs: import pkgs {
        inherit system;
        config = { allowUnfree = true; }; # Forgive me Mr. Stallman
      };

      nomachine-pkgs = unfreeImport nomachine;
      pkgs = unfreeImport nixpkgs;
      master-pkgs = unfreeImport nixpkgs-master;
      logiops-pkgs = unfreeImport logiops;

      overlays = [
        nixpkgs-f2k.overlays.default
        nixpkgs-sheb.overlay
        neovim-nightly.overlays.default
        hyprpaper.overlays.default
        (self: super: { flox = flox.packages.${system}.flox; })
        (self: super: { compfy = compfy.packages.${system}.compfy; })
        (self: super: { nomachine = nomachine-pkgs.nomachine; })
        (self: super: { devenv = devenv.packages.${system}.devenv; })
        (self: super: { formats = logiops-pkgs.formats; })
        (self: super: { nixMaster = master-pkgs.nix; })
        (self: super: {
          nur = import nur {
            nurpkgs = super;
            pkgs = super;
          };
        })
        (self: super: {
          act-latest = master-pkgs.act;
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
          extraSpecialArgs = { inherit inputs; };
          modules = [
            rec {
              home = {
                homeDirectory = "/home/shebpamm";
                username = "shebpamm";
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
          extraSpecialArgs = { inherit inputs; };
          modules = [
            {
              home = {
                homeDirectory = "/home/shebpamm";
                username = "shebpamm";
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
            disko.nixosModules.disko
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
