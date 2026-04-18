{ inputs, ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      hexane = {
        includes = [ aspects.onepassword ];
        homeManager =
          { pkgs, ... }:
          {
            programs.ssh.matchBlocks."*".extraOptions = {
              IdentityAgent = "~/.1password/agent.sock";
            };
            home.sessionVariables.SSH_AUTH_SOCK = "${inputs.self.context.homeDirectory}/.1password/agent.sock";
          };
      };
    };
}
