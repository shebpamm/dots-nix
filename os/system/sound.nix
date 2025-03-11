{ config, pkgs, ... }:
{
  security.rtkit.enable = true;
  services.spotifyd = {
    enable = true;
  };

  services.pipewire = {
    enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
}
