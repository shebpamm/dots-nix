{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      system-base = {
        includes = [
          aspects.nix
          aspects.homemanager-base
          aspects.homelab-cert
          aspects.network
          aspects.ssh
          aspects.users
        ];

        nixos =
          { pkgs, ... }:
          {
            environment.binsh = "${pkgs.dash}/bin/dash";
            services.automatic-timezoned.enable = true;
          };
      };
    };
}
