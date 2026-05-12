{ inputs, ... }:
{
  flake.aspects = { ... }: {
    kubernetes = {
      homeManager = { pkgs, ... }: {
        imports = [ inputs.self.wrappers.kubectl.install ];

        wrappers.kubectl.enable = true; 
      };
    };
  };
}
