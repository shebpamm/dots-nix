{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      users = {
        includes = [ ];

        nixos =
          {
            pkgs,
            config,
            lib,
            ...
          }:
          {
            options.dots.users = {

              defaultShell = lib.mkOption {
                type = lib.types.shellPackage;
                default = pkgs.bashInteractive;
                description = "Default shell for users.";
              };

              rootPasswordFile = lib.mkOption {
                type = lib.types.path;
                default = config.sops.secrets.root-password.path;
                description = "Path to file containing root password hash. Typically passed from sops.";
              };

              enableAdminUser = lib.mkOption {
                type = lib.types.bool;
                default = true;
                description = "Whether to create user from self.context.adminUser";
              };

              adminPasswordFile = lib.mkOption {
                type = lib.types.path;
                default = config.sops.secrets.main-password.path;
                description = "Path to file containing admin user password hash. Typically passed from sops.";
              };
            };

            config.users = {
              mutableUsers = false;

              users = {
                root = {
                  shell = config.dots.users.defaultShell;
                  hashedPasswordFile = config.dots.users.rootPasswordFile;
                };
                ${inputs.self.context.adminUser} = {
                  enable = config.dots.users.enableAdminUser;
                  shell = config.dots.users.defaultShell;

                  hashedPasswordFile = config.dots.users.adminPasswordFile;

                  isNormalUser = true;
                  extraGroups = [
                    "wheel"
                    "networkmanager"
                  ];
                };
              };
            };
          };
      };
    };
}
