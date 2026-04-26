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
          aspects.steam
          aspects.neovim
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
