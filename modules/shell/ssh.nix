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
        };
    };
}
