{ config, pkgs, ... }:
{
  modules = [ sops-nix.nixosModules.sops ];

  # Expose secrets
  sops.defaultSopsFile = ../../secrets/default.yaml;
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.secrets.hass-server = {
    mode = "0400";
    owner = "shebpamm";
  };

  sops.secrets.hass-token = {
    mode = "0400";
    owner = "shebpamm";
  };

  sops.secrets.hass-phone = {
    mode = "0400";
    owner = "shebpamm";
  };

  sops.secrets."shebpamm-libera.crt" = {
    mode = "0400";
    owner = "shebpamm";
  };
}
