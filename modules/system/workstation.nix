{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      workstation = {
        includes = [
          aspects.system-base
          aspects.cross-platform
          aspects.keyring
          aspects.yubikey
          aspects.fish
        ];

        nixos =
          { pkgs, ... }:
          {
            environment.systemPackages = with pkgs; [
              gcc
            ];
          };
      };
    };
}
