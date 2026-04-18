{ ... }:
{
  flake.aspects =
    { ... }:
    {
      yubikey = {
        nixos =
          { pkgs, ... }:
          {
            services.pcscd.enable = true;

            programs.gnupg.agent = {
              enable = true;
            };

            environment.systemPackages = [ pkgs.gnupg ];
          };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              yubioath-flutter
              yubikey-agent
              yubikey-manager
            ];
          };
      };
    };
}
