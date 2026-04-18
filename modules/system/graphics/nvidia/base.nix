{ ... }:
{
  flake.aspects = { ... }: {
    nvidia-base = {
      nixos = { lib, ... }: {
        hardware.nvidia.modesetting.enable = true;

        # Default to open drivers, but allow eg. prime to declare closed source drivers
        hardware.nvidia.open = lib.mkDefault true;
        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.graphics.enable32Bit = true;

        virtualisation.docker.enableNvidia = true;
      };
      homeManager = { pkgs, ... }: { };
    };
  };
}
