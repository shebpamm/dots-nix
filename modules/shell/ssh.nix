{ config, pkgs, libs, ... }:
{
  programs.ssh = {
      enable = true;
      forwardAgent = true;
      hashKnownHosts = true;

      matchBlocks = {
          "*" = {
              user = "shebpamm@ad.sorsa.cloud";
          };
          showrunner = {
              user = "shebpamm";
          };
          "askola-ssh.opcode.xyz" = {
            user = "shebpamm123";
            extraOptions = {
              ProxyCommand = "bash -c '/home/shebpamm/.nix-profile/bin/cloudflared access ssh-gen --hostname %h; ssh -tt shebpamm123@cfpipe-askola-ssh.opcode.xyz >&2 <&1'";
            };
          };

          "cfpipe-askola-ssh.opcode.xyz" = {
            extraOptions = {
              HostName = "askola-ssh.opcode.xyz";
              ProxyCommand = "/home/shebpamm/.nix-profile/bin/cloudflared access ssh --hostname %h";
              IdentityFile = "~/.cloudflared/askola-ssh.opcode.xyz-cf_key";
              CertificateFile = "~/.cloudflared/askola-ssh.opcode.xyz-cf_key-cert.pub";
            };
          };
        };
    };
}
