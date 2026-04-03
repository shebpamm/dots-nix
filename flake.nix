# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: import ./outputs.nix inputs;

  inputs = {
    anttipkgs.url = "github:anttiharju/nur-packages";
    catppuccin.url = "github:catppuccin/nix";
    compfy.url = "github:allusive-dev/compfy";
    cursor = {
      url = "github:thinktankmachine/cursor-nixos-flake";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    disko.url = "github:nix-community/disko";
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    flox.url = "github:flox/flox";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper = {
      url = "github:shebpamm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kat.url = "github:macropower/nur-packages";
    logiops.url = "github:ckiee/nixpkgs/logiops-nixos";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-f2k.url = "github:shebpamm/nixpkgs-f2k";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-sheb = {
      url = "github:shebpamm/nixpkgs-sheb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    spicetify.url = "github:Gerg-L/spicetify-nix";
    zen.url = "github:0xc000022070/zen-browser-flake";
  };
}
