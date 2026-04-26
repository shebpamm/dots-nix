{ ... }:
{
  flake.aspects =
    { ... }:
    {
      homelab-cert = {
        nixos =
          { ... }:
          {
            security.pki.certificateFiles = [ ../../home.crt ];
          };
        homeManager = { ... }: { };
      };
    };
}
