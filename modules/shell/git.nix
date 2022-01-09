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

    aliases = {
      co = "checkout";
      br = "branch";
      st = "status";
      cm = "commit -m";  
      amend = "commit --amend";
      dfs = "diff --staged";
      a = "add";
    };

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
      "credential \"https://github.com\"" = {
          helper = "!${pkgs.github-cli}/bin/gh auth git-credential";
        };
    };
  };
}
