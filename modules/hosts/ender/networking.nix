{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      ender = {
        includes = [ aspects.wireless-secrets ];
        nixos =
          { config, ... }:
          {
            networking = {
              hostName = "enderpi";
              wireless = {
                enable = true;
                networks."SorsaNet2400" = {
                  pskRaw = "ext:WIFI_PSK";
                };
                secretsFile = config.sops.templates.home_wifi_psk_wpa.path;
              };
            };
          };
      };
    };
}
