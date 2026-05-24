{ ... }:
{
  flake.aspects =
    { ... }:
    {
      discord = {
        homeManager =
          { pkgs, ... }:
          {
            programs.vesktop.enable = true;
            home.packages = with pkgs; [
              (discord.override {
                withVencord = true;
              })
            ];
          };
      };
    };
}
