{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      workstation = {
        includes = [
          aspects.system-base
          aspects.cross-platform
          aspects.keyring
          aspects.yubikey
          aspects.fish
          aspects.docker
          aspects.rtl-sdr
          aspects.clamav
        ];

        nixos =
          { pkgs, ... }:
          {
            environment.systemPackages = with pkgs; [
              gcc
            ];
          };
      };
    };
}
