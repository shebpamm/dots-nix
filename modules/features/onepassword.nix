{ ... }:
{
  flake.aspects =
    { ... }:
    {
      onepassword = {
        nixos =
          { pkgs, ... }:
          {
            programs._1password.enable = true;
            programs._1password-gui.enable = true;
            programs._1password-gui.polkitPolicyOwners = [ "shebpamm" ];
          };
        homeManager =
          { pkgs, ... }:
          { };
      };
    };
}
