{ inputs, ... }:
{
  flake-file.inputs.spicetify.url = "github:Gerg-L/spicetify-nix";

  flake.aspects =
    { ... }:
    {
      spotify = {
        homeManager =
          { pkgs, ... }:
          {
            imports = [ inputs.spicetify.homeManagerModules.default ];

            home.packages = with pkgs; [
              spotify-player
            ];
            programs.spicetify = {
              enable = true;
              theme = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.catppuccin;
            };
          };
      };
    };
}
