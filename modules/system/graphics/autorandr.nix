{ ... }:
{
  flake.aspects =
    { ... }:
    {
      autorandr = {
        nixos =
          { pkgs, ... }:
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
