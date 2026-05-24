{ ... }:
{
  flake.aspects =
    { ... }:
    {
      server = {
        nixos =
          { ... }:
          {
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
