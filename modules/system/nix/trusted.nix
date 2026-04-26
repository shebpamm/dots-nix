{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      nix = {
        nixos =
          { ... }:
          {
            nix = {
              settings = {
                trusted-users = [
                  "root"
                  "@wheel"
                ]
                ++ [ inputs.self.context.adminUser ];
              };
            };
          };
        homeManager = { ... }: { };
      };
    };
}
