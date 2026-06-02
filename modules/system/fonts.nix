{ inputs, ... }:
{
  flake-file.inputs.sheb-icons.url = "github:shebpamm/icons";
  flake-file.inputs.sheb-icons.inputs.nixpkgs.follows = "nixpkgs";
  flake-file.inputs.sheb-icons.group = "icons";

  flake.aspects =
    { ... }:
    {
      fonts = {
        nixos =
          { pkgs, ... }:
          {
            fonts.packages = with pkgs; [
              nerd-fonts._3270
              nerd-fonts.jetbrains-mono
              font-awesome
              cantarell-fonts
              cascadia-code
              comic-mono
              fira-code
              material-icons
              meslo-lg
              noto-fonts
              noto-fonts-emoji-blob-bin

              inputs.sheb-icons.packages.${stdenv.hostPlatform.system}.default
            ];

            fonts.fontconfig = {
              defaultFonts = {
                monospace = [ "Cousine" ];
                sansSerif = [ "Arimo" ];
                serif = [ "Tinos" ];
                emoji = [ "Blobmoji" ];
              };
            };
          };
        homeManager = { ... }: { };
      };
    };
}
