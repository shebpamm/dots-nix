{ ... }:
{
  flake.aspects =
    { ... }:
    {
      mtp = {
        nixos =
          { pkgs, ... }:
          {
            environment.systemPackages = with pkgs; [
              jmtpfs
            ];
          };
      };
    };
}
