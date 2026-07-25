{ ... }:
{
  flake.aspects =
    { aspects, ... }:
    {
      homestack = {
        includes = [
          aspects.server
        ];

        nixos = {
          system.stateVersion = "23.11";
          networking.hostName = "homestack";
        };
        terraform = { };
      };
    };
}
