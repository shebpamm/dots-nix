{ ... }:
{
  flake.aspects = { ... }: {
    keyring = {
      nixos = { pkgs, ... }: {
        services.gnome.gnome-keyring.enable = true;
      };
    };
  };
}
