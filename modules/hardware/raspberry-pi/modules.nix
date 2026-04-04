{ inputs, ... }:
{
  flake-file.inputs = {
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };

  flake.aspects = {
    raspberry-pi-5 = {
      nixos = {
        imports = with inputs.nixos-raspberrypi.nixosModules; [
          sd-image
          raspberry-pi-5.base
          raspberry-pi-5.page-size-16k
          raspberry-pi-5.display-vc4
        ];
      };
    };
  };
}
