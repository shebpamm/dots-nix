{ ... }:
{
  flake.aspects =
    { ... }:
    {
      openssl = {
        nixos = { ... }: { };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              openssl
              cfssl
            ];
          };
      };
    };
}
