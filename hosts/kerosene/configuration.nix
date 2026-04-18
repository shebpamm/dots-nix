{ config, pkgs, ... }:

{
  imports =
    [
      ../../os/system
      ../../os/system/keyboard.nix
      # ../../os/system/graphics/wayland.nix
      ../../os/system/graphics/xorg.nix
    ];
}
