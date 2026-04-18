{ ... }:
{
  flake.aspects =
    { ... }:
    {
      hexane = {
        homeManager =
          { lib, ... }:
          {
            programs.ssh.enable = lib.mkForce false;
          };
      };
    };
}
