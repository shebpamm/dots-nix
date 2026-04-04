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
      };
    };
}
