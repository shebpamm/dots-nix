{ config, pkgs, ... }:
{
  disko.devices = {
    disk.vda = {
      device = "/dev/vda";
      type = "disk";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            type = "partition";
            name = "ESP";
            start = "1MiB";
            end = "100MiB";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }
          {
            name = "luks";
            type = "partition";
            start = "100MiB";
            end = "100%";
            content = {
              type = "luks";
              name = "crypted";
              extraOpenArgs = [ "--allow-discards" ];
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
            };
          }
        ];
      };
    };
  };
}
