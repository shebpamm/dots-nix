{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      roto-control = {
        nixos =
          { ... }:
          {
            users.extraGroups.plugdev.members = [ inputs.self.context.adminUser ];
            users.extraGroups.dialout.members = [ inputs.self.context.adminUser ];
            services.udev.extraRules = ''
              SUBSYSTEM=="usb", ATTR{idVendor}=="2e8a", ATTR{idProduct}=="0003", GROUP="plugdev"
            '';
          };
        homeManager =
          { pkgs, ... }:
          let
            roto-setup = pkgs.appimageTools.wrapType2 rec {
              version = "3.2.1";
              pname = "roto-setup";

              src = pkgs.fetchurl {
                url = "https://update.melbourneinstruments.com/roto-control/ROTO-SETUP-${version}-x64.AppImage";
                hash = "sha256-rWwBYDrL+2tYMxonIqdenDvJaXzKxTz3kYce91RPzLA=";
              };
            };
          in
          {
            home.packages = [ roto-setup ];
          };
      };
    };
}
