{ ... }:
{
  flake.aspects = { ... }: {
    ssh = {
      nixos = { pkgs, ... }: {
        services.sshd.enable = true;

      };
      homeManager = { pkgs, ... }: {
        programs.ssh = {
          enable = true;
          forwardAgent = true;
          hashKnownHosts = true;
        };
      };
    };
  };
}
