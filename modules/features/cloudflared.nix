{ ... }:
{
  flake.aspects =
    { ... }:
    {
      cloudflared = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              cloudflared
            ];
          };
      };
    };
}
