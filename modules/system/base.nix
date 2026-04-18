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
        ];

        nixos =
          { pkgs, ... }:
          {
            environment.binsh = "${pkgs.dash}/bin/dash";

            environment.systemPackages = with pkgs; [
              coreutils
              git
              usbutils
              vim
            ];

            hardware.enableRedistributableFirmware = true;
            hardware.enableAllFirmware = true;

            services.automatic-timezoned.enable = true;
          };
      };
    };
}
