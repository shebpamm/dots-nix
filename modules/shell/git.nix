{ config, pkgs, libs, ... }:
{
  programs.git = {
    enable = true;
    userName = "shebpamm";
    userEmail = "erik@opcode.xyz";
    ignores = [
      "*.o"
      ".DS_Store"
    ];
    extraConfig = {
      url = {
        "git://github.com/" = {
          insteadOf = "github:";
        };
        "git@github.com:" = {
          insteadOf = "gh:";
          pushInsteadOf = [ "github:" "git://github.com/" ];
        };
      };
    };
  };
}
