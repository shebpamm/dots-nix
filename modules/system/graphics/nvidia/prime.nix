{ ... }:
{
  flake.aspects = { aspects, ... }: {
    nvidia-prime = {
      includes = [ aspects.nvidia-base ];

      nixos = { ... }: {
        hardware.nvidia = {
          modesetting.enable = true;
          open = false;
          prime = {
            sync.enable = true;
            offload.enable = false;
          };
        };
      };
    };
  };
}
