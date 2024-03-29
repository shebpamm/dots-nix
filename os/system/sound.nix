{ config, pkgs, ... }:
{
  sound.enable = true;
  #hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.spotifyd = {
    enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
}
