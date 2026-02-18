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

  # The releases/tags have not been updated forever, so locked to a recent commit instead.
  jira = pkgs.go-jira.overrideAttrs (oldAttrs: rec {
    pname = "go-jira";
    src = pkgs.fetchFromGitHub {
      owner = "go-jira";
      repo = "jira";
      rev = "748b7d552f8b3ad993b05810b93f0f2ed39822d1";
      sha256 = "sha256-PFmgnGGayrgcC46UvvSzCQ1uVc87H1kgWBdMrcCRZD4=";
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
    awscli2
    jira
  ];
}
