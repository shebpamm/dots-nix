{ ... }:
{
  flake.aspects =
    { ... }:
    {
      keyring = {
        nixos =
          { ... }:
          {
            services.gnome.gnome-keyring.enable = true;
          };
      };
    };
}
