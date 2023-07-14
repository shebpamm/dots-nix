{ pkgs, ... }:
let
  tmux-git = pkgs.tmux.overrideAttrs (_: {
    pname = "tmux-git";
    patches = [];
    src = pkgs.fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      rev = "0e281530cbec0710a06692f00d89faa3a7d87e2f";
      sha256 = "sha256-2gmr2bWv3Aix8Lgvh95J8oo7kZxM7HF/Tm8mRdzPNSU";
    };
  });
in
{
  home.packages = [ tmux-git ];
}
