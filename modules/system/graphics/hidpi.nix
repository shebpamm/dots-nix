{ ... }:
{
  flake.aspects = { ... }: {
    hidpi = {
      nixos = { pkgs, ... }: {
        services.xserver.dpi = 96;
        environment.variables = {
          GDK_SCALE = "1";
          GDK_DPI_SCALE = "1";
          _JAVA_OPTIONS = "-Dsun.java2d.uiScale=1";
        };
      };
      homeManager = { pkgs, ... }: { };
    };
  };
}
