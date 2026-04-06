{ ... }:
{
  flake.aspects = { ... }: {
    kerosene = {
      nixos = { ... }: {
        networking = {
          hostName = "kerosene";
          useDHCP = false;

          interfaces.eno1.useDHCP = true;
          firewall.allowedTCPPorts = [ 80 443 22 6742 8000 24800 4713 3389 ];
          dhcpcd.wait = "if-carrier-up";

        };
      };
      homeManager = { ... }: { };
    };
  };
}
