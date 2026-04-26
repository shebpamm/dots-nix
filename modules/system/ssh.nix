{ ... }:
{
  flake.aspects =
    { ... }:
    {
      ssh = {
        nixos =
          { ... }:
          {
            services.sshd.enable = true;

          };
        homeManager =
          { ... }:
          {
            programs.ssh = {
              enable = true;
              forwardAgent = true;
              hashKnownHosts = true;
            };
          };
      };
    };
}
