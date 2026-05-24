{ ... }:
{
  flake.aspects =
    { ... }:
    {
      wireless-secrets = {
        nixos =
          { config, ... }:
          {
            sops.defaultSopsFile = ../../secrets/default.yaml;
            sops.age.sshKeyPaths = [
              "/etc/ssh/ssh_sops_key"
            ];

            sops.secrets = {
              wifi-psk-wpa = {
                owner = "root";
                mode = "0400";
              };
            };

            sops.templates = {
              home_wifi_psk_wpa = {
                content = "WIFI_PSK=${config.sops.placeholder.wifi-psk-wpa}";
                owner = "root";
                mode = "0400";
              };
            };
          };
        homeManager = { ... }: { };
      };
    };
}
