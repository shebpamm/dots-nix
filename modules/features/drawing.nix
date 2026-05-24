{ ... }:
{
  flake.aspects =
    { ... }:
    {
      drawing = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              gimp
              inkscape
              krita
              graphviz
            ];
          };
      };
    };
}
