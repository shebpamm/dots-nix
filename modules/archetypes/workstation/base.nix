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
          aspects.vim
          aspects.treefmt
          aspects.sound
          aspects.spotify
          aspects.clipcat
          aspects.gtk
          aspects.irssi
          aspects.rofi
          aspects.kubernetes
          aspects.direnv
          aspects.discord
          aspects.vscode
          aspects.bitwarden
          aspects.firefox
          aspects.chrome
          aspects.network-utils
          aspects.wireshark
          aspects.kitty
          aspects.wezterm
          aspects.mplayer
          aspects.openssl
          aspects.pcmanfm
          aspects.flox
          aspects.fun
          aspects.drawing
          aspects.warriors
          aspects.cloudflared
          aspects.ripgrep
          aspects.shell-utils
          aspects.media-utils
          aspects.git
          aspects.gnumake
          aspects.homeassistant
          aspects.passwords
          aspects.vault
          aspects.relcheck
          aspects.scripts
          aspects.tmux
          aspects.bat
          aspects.fortunes
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
