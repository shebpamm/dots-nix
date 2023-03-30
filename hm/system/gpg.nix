{ config, pkgs, ... }:
{
  home.file.".gnupg/S.gpg-agent".text = ''
    %Assuan%
    socket=/run/user/1000/gnupg/S.gpg-agent
  '';

  home.file.".gnupg/S.gpg-agent.ssh".text = ''
    %Assuan%
    socket=/run/user/1000/gnupg/S.gpg-agent.ssh
  '';

  home.file.".gnupg/gpg-agent.conf".text = ''
    extra-socket /run/user/1000/gnupg/S.gpg-agent.extra
  '';
}
