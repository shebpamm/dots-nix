{ ... }:
{
  flake.aspects = { ... }: {
    hexane = {
      nixos = { pkgs, ... }: {
        networking = {
          hostName = "hexane";
          nameservers = [ "1.1.1.1" "8.8.8.8" ];
          enableIPv6 = true;
          useDHCP = true;
          wireless.iwd.enable = true;
          search = [
            "smartly.io"
          ];
        };
      };
      homeManager = { pkgs, ... }: { };
    };
  };
}
