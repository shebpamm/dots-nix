{ ... }:
{
  flake.aspects =
    { ... }:
    {
      logitech = {
        nixos =
          { ... }:
          {
            services.ratbagd.enable = true;
          };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [ piper ];
          };
      };
    };
}

