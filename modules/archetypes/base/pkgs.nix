{ ... }:
{
  flake.aspects =
    { ... }:
    {
      system-base = {
        nixos =
          { pkgs, ... }:
          {
            environment.systemPackages = with pkgs; [
              coreutils
              git
              usbutils
              vim
              file
            ];
          };
        homeManager = { ... }: { };
      };
    };
}
