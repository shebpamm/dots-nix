{ ... }:
{
  flake.aspects =
    { ... }:
    {
      network-utils = {
        nixos = { ... }: { };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              iperf3
              tcpdump
              traceroute
              mtr
            ];
          };
      };
    };
}
