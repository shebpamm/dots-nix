{ inputs, ... }: {
  systems = [ "x86_64-linux" "aarch64-linux" ];

  flake =
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

      pkgs = unfreeImport inputs.nixpkgs;
      master-pkgs = unfreeImport inputs.nixpkgs-master;

      overlays = [
        inputs.nixpkgs-f2k.overlays.default
        inputs.nixpkgs-sheb.overlay
        inputs.neovim-nightly.overlays.default
        inputs.hyprpaper.overlays.default
        inputs.anttipkgs.overlays.default
        (self: super: {
          zen-browser = inputs.zen.packages.${system}.default;
          flox = inputs.flox.packages.${system}.flox;
          compfy = inputs.compfy.packages.${system}.compfy;
          devenv = inputs.devenv.packages.${system}.devenv;
          kat = inputs.kat.packages.${system}.kat;
          nixMaster = master-pkgs.nix;
          nur = import inputs.nur {
            nurpkgs = super;
            pkgs = super;
          };
          act-latest = master-pkgs.act;
          cursor-latest = inputs.cursor.packages.${system}.cursor;
        })
      ];

      defaultHomeManagerModules = [
        inputs.catppuccin.homeManagerModules.catppuccin
      ];
    in
    {
      homemanagerConfigurations = {
        kerosene = inputs.home-manager.lib.homeManagerConfiguration {
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

            ../hm/system/openrgb.nix
            ../hm/system/clipcat.nix
            ../hm/shell
            ../hm/shell/ssh.nix
            ../hm/editors/neovim.nix
            ../hm/editors/vscode.nix
            ../hm/editors/vim.nix
            ../hm/dev
            ../hm/programs
            ../hm/programs/xorg.nix
            ../hm/programs/graphics.nix
            ../hm/desktop
            ../hm/desktop/windowManagers/awesome.nix
            # ../hm/desktop/windowManagers/hyprland.nix
          ] ++ defaultHomeManagerModules;
        };

        hexane = inputs.home-manager.lib.homeManagerConfiguration {
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
            ../hm/desktop
            ../hm/desktop/windowManagers/awesome.nix
            ../hm/dev
            ../hm/editors/neovim.nix
            ../hm/editors/vim.nix
            ../hm/editors/vscode.nix
            ../hm/system/clipcat.nix
            ../hm/programs
            ../hm/programs/graphics.nix
            ../hm/programs/xorg.nix
            ../hm/programs/work.nix
            ../hm/shell
          ] ++ defaultHomeManagerModules;
        };

        ethylene = inputs.home-manager.lib.homeManagerConfiguration {
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
            ../hm/shell
            ../hm/editors/neovim.nix
            ../hm/editors/vim.nix
            ../hm/dev
            ../hm/programs
            ../hm/programs/graphics.nix
            ../hm/programs/xorg.nix
            ../hm/programs/work.nix
            ../hm/desktop
            ../hm/desktop/windowManagers/awesome.nix
          ] ++ defaultHomeManagerModules;
        };
      };

      nixosConfigurations = {
        ender = inputs.nixos-raspberrypi.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            {
              nixpkgs.flake = {
                setFlakeRegistry = false;
                setNixPath = false;
              };
              imports = with inputs.nixos-raspberrypi.nixosModules; [
                sd-image
                raspberry-pi-5.base
                raspberry-pi-5.page-size-16k
                raspberry-pi-5.display-vc4
              ];
            }
            ../hosts/ender/configuration.nix
          ];
          specialArgs = {
            inherit inputs context;
            nixos-raspberrypi = inputs.nixos-raspberrypi;
          };
        };
      };
    };
}
