{ ... }:
{
  flake.aspects =
    { ... }:
    {
      autorandr = {
        nixos =
          { ... }:
          {
            services.autorandr.enable = true;
            systemd.services.autorandr.after = [ "graphical-session-pre.target" ];
            systemd.services.autorandr.partOf = [ "graphical-session.target" ];
          };

        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              autorandr
            ];
          };
      };
    };
}
