{ ... }:
{
  flake.aspects =
    { ... }:
    {
      workstation = {
        nixos =
          { ... }:
          {

            sops.defaultSopsFile = ../../secrets/default.yaml;
            sops.age.sshKeyPaths = [
              "/etc/ssh/ssh_sops_key"
            ];

            sops.secrets = {
              hass-server = {
                mode = "0400";
                owner = "shebpamm";
              };

              hass-token = {
                mode = "0400";
                owner = "shebpamm";
              };

              hass-phone = {
                mode = "0400";
                owner = "shebpamm";
              };

              openai-api-key = {
                mode = "0400";
                owner = "shebpamm";
              };

              jira-api-token = {
                mode = "0400";
                owner = "shebpamm";
              };

              pagerduty-api-token = {
                mode = "0400";
                owner = "shebpamm";
              };

              spotify-password = {
                mode = "0400";
                owner = "shebpamm";
              };

              "shebpamm-libera.crt" = {
                mode = "0400";
                owner = "shebpamm";
              };
            };
          };
        homeManager = { ... }: { };
      };
    };
}
