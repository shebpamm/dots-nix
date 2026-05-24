{ ... }:
{
  flake.aspects =
    { ... }:
    {
      fun = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              cmatrix
              lolcat
              pipes-rs
              pfetch
              fastfetch
            ];
          };
      };
    };
}
