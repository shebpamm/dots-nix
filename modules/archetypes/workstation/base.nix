{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      workstation = {
        includes = [
          aspects.system-base
          aspects.awesome
          aspects.cross-platform
          aspects.keyring
          aspects.fonts
          aspects.yubikey
          aspects.fish
          aspects.zsh
          aspects.docker
          aspects.rtl-sdr
          aspects.clamav
          aspects.steam
          aspects.neovim
          aspects.treefmt
          aspects.sound
          aspects.spotify
          aspects.clipcat
          aspects.gtk
          aspects.rofi
          aspects.kubernetes
          aspects.direnv
          aspects.claude
        ];

        nixos =
          { pkgs, ... }:
          {
            # Use fish as default shell on workstations
            dots.users.defaultShell = pkgs.fish;

            environment.systemPackages = with pkgs; [
              gcc
            ];
          };
      };
    };
}
