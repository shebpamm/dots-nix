{ ... }:
{
  flake.aspects = { ... }: {
    nix = {
      nixos = { ... }: {
        nix.extraOptions = ''
          experimental-features = nix-command flakes
        '';

      };
      homeManager = { ... }: { };
    };
  };
}
