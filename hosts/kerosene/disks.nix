{ ... }:
{
  disko.devices = {
    disk.booter = {
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            name = "ESP";
            start = "1MiB";
            end = "1000MiB";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }
        ];
      };
    };
    disk.nvme = {
      device = "/dev/nvme2n1";
      type = "disk";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            name = "ESP";
            start = "1MiB";
            end = "1000MiB";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/tiny-boot";
            };
          }
          {
            name = "main";
            start = "100MiB";
            end = "100%";
            content = {
              type = "btrfs";
              subvolumes = {
                "/@" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" ];
                };
                "/@home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" ];
                };
                "/@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/@swap" = {
                  mountpoint = "/swap";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/@snapshots" = {
                  mountpoint = "/snapshots";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
              };
            };
          }
        ];
      };
    };
  };
}
