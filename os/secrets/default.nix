{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    ./users.nix
  ];



  # Enable GPG
  programs.gnupg.agent = {
    enable = true;
  };

  # Enable smart card service to access Yubikeys
  services.pcscd.enable = true;

  environment.systemPackages = [ pkgs.gnupg pkgs.pinentry ];


  # Expose secrets
  sops.defaultSopsFile = ../../secrets/default.yaml;
  sops.gnupg.sshKeyPaths = [];
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

    "shebpamm-libera.crt" = {
      mode = "0400";
      owner = "shebpamm";
    };
  };

}
