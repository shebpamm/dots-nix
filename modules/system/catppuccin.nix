{ inputs, ... }:
{
  flake-file.inputs.catppuccin.url = "github:catppuccin/nix";

  flake.aspects =
    { ... }:
    {
      catppuccin = {
        nixos =
          { ... }:
          {

          };
        homeManager =
          { ... }:
          {
            imports = [
              inputs.catppuccin.homeManagerModules.catppuccin
            ];

            catppuccin.flavor = "frappe";
          };
      };
    };
}
