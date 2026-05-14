{ ... }:
{
  flake.aspects =
    { ... }:
    {
      steam = {
        nixos =
          { pkgs, ... }:
          {
            programs.steam = {
              enable = true;
              remotePlay.openFirewall = true;

              # Bitburner needs these
              extraPackages = with pkgs; [
                nspr
                nss
              ];
            };
          };
        homeManager = { ... }: { };
      };
    };
}
