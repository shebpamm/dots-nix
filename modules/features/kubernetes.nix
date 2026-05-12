{ inputs, ... }:
{

  flake-file.inputs.kat.url = "github:macropower/nur-packages";
  flake.aspects =
    { ... }:
    {
      kubernetes = {
        homeManager =
          { pkgs, ... }:
          {
            imports = [ inputs.self.wrappers.kubectl.install ];

            wrappers.kubectl.enable = true;

            home.packages = with pkgs; [
              inputs.kat.packages.${pkgs.stdenv.hostPlatform.system}.kat
              kubectx
              kubernetes-helm
              kustomize
            ];
          };
      };
    };
}
