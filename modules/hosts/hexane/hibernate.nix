{ ... }:
{
  flake.aspects =
    { ... }:
    {
      hexane = {
        nixos =
          { pkgs, ... }:
          {
            boot.resumeDevice = "/dev/mapper/crypted";
            boot.kernelParams = [
              "resume_offset=3155204"
            ];
          };
      };
    };
}
