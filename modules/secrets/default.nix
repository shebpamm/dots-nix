{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    ./users.nix
  ];

  # Expose secrets
  sops.defaultSopsFile = ../../secrets/default.yaml;
  sops.age.sshKeyPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
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

    "shebpamm-libera.crt" = {
      mode = "0400";
      owner = "shebpamm";
    };
  };

}