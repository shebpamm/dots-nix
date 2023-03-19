{ config, pkgs, inputs, ... }:
{
  sops.secrets = {
    root-password = {
      neededForUsers = true;
      sopsFile = ../../secrets/users.yaml;
    };

    main-password = {
      neededForUsers = true;
      sopsFile = ../../secrets/users.yaml;
    };
  };
}
