{ inputs, ... }:
{
  flake.aspects =
    { ... }:
    {
      sound = {
        nixos =
          { ... }:
          {
            security.rtkit.enable = true;

            services.pipewire = {
              enable = true;
              jack.enable = true;
              alsa = {
                enable = true;
                support32Bit = true;
              };
              pulse.enable = true;
            };
            users.extraGroups.audio.members = [ inputs.self.context.adminUser ];
          };
        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              pavucontrol
              pulseaudio
            ];
          };
      };
    };
}
