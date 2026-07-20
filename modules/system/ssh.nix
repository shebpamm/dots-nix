{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      ssh = {
        nixos =
          { ... }:
          let
            inherit (inputs.self.context) adminUser adminPubKey;
          in
          {
            services.sshd.enable = true;
            users.users.${adminUser}.openssh.authorizedKeys.keys = [ adminPubKey ];
            users.users.root.openssh.authorizedKeys.keys = [ adminPubKey ];
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
