{ ... }:
{
  flake.aspects =
    { ... }:
    {
      ollama =
        let
          overlay = self: _super: {
            ollama-cuda-latest = self.ollama-cuda.overrideAttrs (_prev: {
              version = "0.22.1";
              doCheck = false;
              src = self.fetchFromGitHub {
                owner = "ollama";
                repo = "ollama";
                rev = "v0.22.1";
                sha256 = "sha256-dCKGTu004PswCblMT86bEn6bJNipNFK+mG+0+hAP5LA=";
              };
            });
          };
        in
        {
          nixos =
            { pkgs, ... }:
            {
              nixpkgs.overlays = [ overlay ];

              services.ollama.enable = true;
              services.ollama.package = pkgs.ollama-cuda-latest;
            };
          homeManager =
            { pkgs, ... }:
            {
              nixpkgs.overlays = [ overlay ];

              home.packages = [ pkgs.ollama-cuda-latest ];
            };
        };
    };
}
