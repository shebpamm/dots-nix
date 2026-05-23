{ ... }:
{
  flake.aspects =
    { ... }:
    {
      nas-mount = {
        nixos =
          { ... }:
          {
            fileSystems."/mnt/storage" = {
              device = "hc4nas.sorsa.cloud:/mnt/tank/storage";
              fsType = "nfs";
              options = [
                "nfsvers=3"
                "soft"
                "intr"
                "x-systemd.idle-timeout=600"
                "x-systemd.automount"
                "noatime"
                "noauto"
                "nolock"
                "rsize=8192"
                "wsize=8192"
                "timeo=14"
                "retrans=2"
              ];
            };
          };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              nfs-utils
            ];
          };
      };
    };
}
