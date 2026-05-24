{ ... }:
{
  flake.aspects =
    { ... }:
    {
      homelab-cert = {
        nixos =
          { ... }:
          {
            security.pki.certificateFiles = [ ../../config/home.crt ];
          };
        homeManager = { ... }: { };
      };
    };
}
