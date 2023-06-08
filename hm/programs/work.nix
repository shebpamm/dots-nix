{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    slack
    keepassxc
    openvpn
    libsecret
    vault
    git-crypt
    aws-vault
    go-jira
  ];

  home.file.".config/keepassxc/keepassxc.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/keepassxc/keepassxc.ini";
}
