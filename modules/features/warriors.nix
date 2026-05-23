{ ... }:
{
  flake.aspects =
    { ... }:
    {
      warriors = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              timewarrior
              taskwarrior2
            ];
          };
      };
    };
}
