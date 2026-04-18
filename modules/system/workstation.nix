{ ... }:
{
  flake.aspects = { aspects, ... }: {
    workstation = {
      includes = [
        aspects.system-base
        aspects.cross-platform
        aspects.keyring
        aspects.yubikey
        aspects.fish
      ];
    };
  };
}
