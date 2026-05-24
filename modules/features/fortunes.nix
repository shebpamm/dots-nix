{ ... }:
{
  flake.aspects =
    { ... }:
    {
      fortunes = {
        homeManager =
          { pkgs, ... }:
          let
            devops-fortunes = pkgs.stdenv.mkDerivation {
              name = "devops-fortunes";
              src = pkgs.fetchurl {
                url = "https://gist.githubusercontent.com/textarcana/676ef78b2912d42dbf355a2f728a0ca1/raw/f50d5792496b551c847cc3deb04959daf7dd2638/devops_borat.dat";
                sha256 = "sha256-5Wm0NIIJ2ERljjGelhcsbHhFZnydc2ypUMaVbq8EtBM=";
              };
              dontUnpack = true;
              buildInputs = [ pkgs.fortune ];
              installPhase = ''
                mkdir -p $out/share/fortune
                cp $src $out/share/fortune/devops
                strfile $out/share/fortune/devops
              '';
            };
          in
          {
            home.packages = [
              pkgs.fortune
            ];

            programs.fish.functions.fish_greeting = {
              description = "Greeting displayed at start of shell";
              body = ''
                set_color yellow

                fortune ${devops-fortunes}/share/fortune

                set_color normal
              '';
            };

            home.file.".fortunes".source = "${devops-fortunes}/share/fortune";
          };
      };
    };
}
