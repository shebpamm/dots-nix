{ ... }:
{
  flake.aspects =
    { ... }:
    {
      dns = {
        nixos =
          { ... }:
          {
            # mDNS, eg. the .local domain
            services.avahi = {
              enable = true;
              nssmdns4 = true;
            };
          };
      };
    };
}
