{ ... }:
{
  flake.aspects =
    { ... }:
    {
      git = {
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              github-cli
            ];

            programs.fish.shellAbbrs = {
              "ghf" = "gh run list -u (gh-user) -s failure";
              "gpc" = "gh pr checkout";
              "gpcl" = "gh pr checkout (gh-last-pr)";
              "grb" = "gh repo browse -w";
              "gpcr" = "gh pr create -w";
              "gpv" = "gh pr view -w";
            };
          };
      };
    };
}
