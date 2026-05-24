{ inputs, ... }:
{
  flake.aspects = {
    legacy = {
      homeManager = {
        imports = [
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };
}
