{ ... }:
{
  flake.aspects =
    { ... }:
    {
      server = {
        nixos =
          { lib, ... }:
          {
            virtualisation.vmware.guest.enable = true;
            virtualisation.virtualbox.guest.enable = lib.mkForce false;
            image.modules.virtualbox =
              { ... }:
              {
                virtualbox = {
                  params = {
                    # Without these, ESXi will complain about the virtual soundcard:
                    # > OVF hardware element 'ResourceType' with instance ID '5': No support for the virtual hardware device type '35'
                    audio = "none";
                    audioout = "off";
                  };
                };
              };
          };
      };
    };
}
