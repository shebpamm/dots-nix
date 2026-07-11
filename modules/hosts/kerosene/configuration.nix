{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      kerosene = {
        includes = [
          aspects.systemd-boot
          aspects.workstation
          aspects.openrgb
          aspects.ntfs
          aspects.nas-mount
          aspects.flipperzero
          aspects.nvidia-base
          aspects.ollama
          # aspects.virtualbox
          aspects.kvm
          aspects.calibre
          aspects.minecraft
          aspects.logitech
          aspects.bluetooth
        ];
      };
    };
}
