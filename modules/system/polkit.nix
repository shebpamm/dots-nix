{ inputs, ... }:
{
  flake-file.inputs = {
    nixpkgs-polkit-pin.url = "github:NixOS/nixpkgs/88d3861acdd3d2f0e361767018218e51810df8a1";
  };

  flake.aspects =
    { ... }:
    {
      polkit = {
        nixos =
          {
            pkgs,
            lib,
            config,
            ...
          }:
          {
            security.polkit.enable = true;
            systemd = {
              user.services.polkit-gnome-authentication-agent-1 = {
                description = "polkit-gnome-authentication-agent-1";
                wantedBy = [ "graphical-session.target" ];
                wants = [ "graphical-session.target" ];
                after = [ "graphical-session.target" ];
                serviceConfig = {
                  Type = "simple";
                  ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                  Restart = "on-failure";
                  RestartSec = 1;
                  TimeoutStopSec = 10;
                };
              };
            };

            # Pin polkit until setuid business is fixed
            security.wrappers.polkit-agent-helper-1 = {
              setuid = true;
              owner = "root";
              group = "root";
              source = "${config.security.polkit.package.out}/lib/polkit-1/polkit-agent-helper-1";
            };

            systemd.sockets."polkit-agent-helper".wantedBy = lib.mkForce [ ];

            security.polkit.package =
              inputs.nixpkgs-polkit-pin.legacyPackages.${pkgs.stdenv.hostPlatform.system}.polkit;
          };
      };
    };
}
