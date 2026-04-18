{ config, pkgs, ... }:

{
  imports =
    [
      ../../os/system
      ../../os/system/keyboard.nix
      # ../../os/system/graphics/wayland.nix
      ../../os/games/steam.nix
      ../../os/programs
      ../../os/secrets
      ../../os/system/graphics/xorg.nix
      ../../os/virtualization/kvm.nix
    ];
}
