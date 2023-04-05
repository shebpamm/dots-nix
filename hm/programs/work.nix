{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    slack
    keepassxc
    openvpn
    libsecret
    vault
    _1password-gui
    _1password
    git-crypt
    aws-vault
  ];

  home.file.".config/keepassxc/keepassxc.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/keepassxc/keepassxc.ini";
}
