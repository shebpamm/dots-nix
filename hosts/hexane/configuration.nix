{ pkgs, ... }:
{
  imports =
    [
      ../../os/system
      ../../os/system/graphics/xorg.nix
      # ../../os/system/fingerprint.nix
      ../../os/secrets
      ../../os/system/keyboard.nix

      ../../os/games/steam.nix
    ];
}
