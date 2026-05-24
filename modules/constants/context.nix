{ lib, ... }:
{
  options.context = lib.mkOption {
    description = "System constants, such as admin username";
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.context = rec {
    adminUser = "shebpamm";
    homeDirectory = "/home/${adminUser}";
    dotfilesPath = "${homeDirectory}/dotfiles";
  };
}
