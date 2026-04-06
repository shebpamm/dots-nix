{ ... }:
{
  flake.aspects = { ... }: {
    homelab-cert = {
      nixos = { pkgs, ... }: {
        security.pki.certificateFiles = [ ../../home.crt ];
      };
      homeManager = { pkgs, ... }: { };
    };
  };
}
