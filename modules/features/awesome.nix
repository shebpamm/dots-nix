{ inputs, ... }:
{
  flake-file.inputs = {
    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
    nixpkgs-f2k.inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects =
    { aspects, ... }:
    {
      awesome = {
        includes = [ aspects.xorg ];
        nixos =
          { pkgs, ... }:
          {
            nix.settings.substituters = [ "https://fortuneteller2k.cachix.org" ];
            nix.settings.trusted-public-keys = [
              "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
            ];

            services.displayManager.defaultSession = "none+awesome";
            services.xserver.windowManager.awesome = {
              enable = true;
              package = inputs.nixpkgs-f2k.packages.${pkgs.stdenv.hostPlatform.system}.awesome-git;
            };
          };
        homeManager = { ... }: { };
      };
    };
}
