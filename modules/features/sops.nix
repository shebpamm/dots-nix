{ inputs, ... }:
{
  flake-file.inputs.sops-nix.url = "github:Mic92/sops-nix";

  flake.aspects =
    { ... }:
    {
      sops = {
        nixos =
          { ... }:
          {
            imports = [ inputs.sops-nix.nixosModules.sops ];
          };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              sops
            ];
          };
      };
    };
}
