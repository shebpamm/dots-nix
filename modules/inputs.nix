{ inputs, ...}:
{
  imports = [
    inputs.flake-file.flakeModules.default
  ];

  flake-file.inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-f2k.url = "github:shebpamm/nixpkgs-f2k";
    nixpkgs-sheb.url = "github:shebpamm/nixpkgs-sheb";
    nixpkgs-sheb.inputs.nixpkgs.follows = "nixpkgs";
    spicetify.url = "github:Gerg-L/spicetify-nix";
    sops-nix.url = "github:Mic92/sops-nix";
    logiops.url = "github:ckiee/nixpkgs/logiops-nixos";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper.url = "github:shebpamm/hyprpaper";
    hyprpaper.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    disko.url = "github:nix-community/disko";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    compfy.url = "github:allusive-dev/compfy";
    flox.url = "github:flox/flox";
    zen.url = "github:0xc000022070/zen-browser-flake";
    catppuccin.url = "github:catppuccin/nix";
    anttipkgs.url = "github:anttiharju/nur-packages";
    kat.url = "github:macropower/nur-packages";
    cursor = {
      url = "github:thinktankmachine/cursor-nixos-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };
}
