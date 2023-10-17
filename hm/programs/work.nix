{ config, pkgs, libs, ... }:
let
  git-crypt-worktrees = pkgs.git-crypt.overrideAttrs (oldAttrs: rec {
    pname = "git-crypt";
    version = "0.6.0";
    src = pkgs.fetchFromGitHub
      {
        owner = "morganwahl";
        repo = pname;
        rev = "use-common-git-dir";
        sha256 = "sha256-f4FjLfVmfLcHpLITQCQaobU10aHifPqhCpamjUrMI/A";
      };
  });

in
{
  home.packages = with pkgs; [
    slack
    openvpn
    libsecret
    vault
    git-crypt-worktrees
    aws-vault
    go-jira
  ];
}
