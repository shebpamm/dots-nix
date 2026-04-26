{ ... }:
{
  flake.aspects =
    { ... }:
    {
      zsh = {
        nixos =
          { ... }:
          {
            programs.zsh = {
              enable = true;
              enableCompletion = true;
              enableGlobalCompInit = false;
            };
          };
        homeManager = { ... }: { };
      };
    };
}
