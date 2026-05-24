# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    anttipkgs.url = "github:anttiharju/nur-packages";
    catppuccin.url = "github:catppuccin/nix";
    claude.url = "github:shebpamm/claude-nix";
    disko.url = "github:nix-community/disko";
    flake-aspects.url = "github:denful/flake-aspects";
    flake-file.url = "github:denful/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flox.url = "github:flox/flox";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:denful/import-tree";
    kat.url = "github:macropower/nur-packages";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-f2k = {
      url = "github:moni-dz/nixpkgs-f2k";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-polkit-pin.url = "github:NixOS/nixpkgs/88d3861acdd3d2f0e361767018218e51810df8a1";
    sops-nix.url = "github:Mic92/sops-nix";
    spicetify.url = "github:Gerg-L/spicetify-nix";
    terranix = {
      url = "github:terranix/terranix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
