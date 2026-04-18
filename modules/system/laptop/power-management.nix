{ ... }:
{
  flake.aspects = { ... }: {
    power-management = {
      nixos = { pkgs, ... }: {
        services.upower.enable = true;
        services.tlp.enable = true;
        services.tlp.settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        };
      };
      homeManager = { pkgs, ... }: { };
    };
  };
}
