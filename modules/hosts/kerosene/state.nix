{ ... }:
{
  flake.aspects = { ... }: {
    kerosene = {
      nixos.system.stateVersion = "23.11";
      home.home.stateVersion = "23.11";
    };
  };
}
