{ ... }:
{
  flake.aspects = { ... }: {
    dns = {
      nixos = { pkgs, ... }: {
        # mDNS, eg. the .local domain
        services.avahi = {
          enable = true;
          nssmdns4 = true;
        };
      };
    };
  };
}
