{ lib, ... }:
{
  options.context = lib.mkOption {
    description = "System constants, such as admin username";
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.context = rec {
    adminUser = "shebpamm";
    adminPubKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK2zXSYBvkCarq9hsQmYAilLbrCaFqDaW7eV8S1nK+oC shebpamm@sorsa.cloud";
    homeDirectory = "/home/${adminUser}";
    dotfilesPath = "${homeDirectory}/dotfiles";
  };
}
