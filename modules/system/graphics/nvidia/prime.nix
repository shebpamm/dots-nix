{ ... }:
{
  flake.aspects = { aspects, ... }: {
    nvidia-prime = {
      includes = [ aspects.nvidia-base ];

      nixos = { pkgs, ... }: {
        hardware.nvidia = {
          modesetting.enable = true;
          open = false;
          prime = {
            sync.enable = true;
            offload.enable = false;
          };

          extraPackages = with pkgs; [ libva libva-vdpau-driver intel-media-driver ];
        };
      };
    };
  };
}
