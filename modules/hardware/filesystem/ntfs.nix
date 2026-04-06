{ ... }:
{
  flake.aspects = { ... }: {
    ntfs = {
      nixos = { ... }: {
        boot.supportedFilesystems = [ "ntfs" ];
      };
      homeManager = { ... }: { };
    };
  };
}
