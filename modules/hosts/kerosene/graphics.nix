{ ... }:
{
  flake.aspects = { aspects, ... }: {
    kerosene = {
      includes = [ aspects.hidpi ];
      nixos = { pkgs, ... }: { };
      homeManager = { pkgs, ... }: { };
    };
  };
}
