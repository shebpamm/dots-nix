{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      svalboard = {
        nixos =
          { ... }:
          {
            users.extraGroups.plugdev.members = [ inputs.self.context.adminUser ];
            users.extraGroups.dialout.members = [ inputs.self.context.adminUser ];
            services.udev.extraRules = ''
              KERNEL=="hidraw*", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="4044", MODE="0660", GROUP="plugdev"
            '';
          };
        homeManager = { ... }: { };
      };
    };
}
