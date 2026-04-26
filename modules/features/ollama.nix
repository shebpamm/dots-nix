{ ... }:
{
  flake.aspects =
    { ... }:
    {
      ollama = {
        nixos =
          { pkgs, ... }:
          {
            services.ollama.enable = true;
            services.ollama.package = pkgs.ollama-cuda;
          };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = [ pkgs.ollama ];
          };
      };
    };
}
