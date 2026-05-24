{ ... }:
{
  flake.aspects =
    { ... }:
    {
      hexane = {
        nixos =
          { ... }:
          {
            boot.resumeDevice = "/dev/mapper/crypted";
            boot.kernelParams = [
              "resume_offset=3155204"
            ];
          };
      };
    };
}
