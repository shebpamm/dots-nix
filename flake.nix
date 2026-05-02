# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

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
    flake-aspects.url = "github:vic/flake-aspects";
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flox.url = "github:flox/flox";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    kat.url = "github:macropower/nur-packages";
    logiops.url = "github:ckiee/nixpkgs/logiops-nixos";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-f2k = {
      url = "github:moni-dz/nixpkgs-f2k";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-polkit-pin.url = "github:NixOS/nixpkgs/88d3861acdd3d2f0e361767018218e51810df8a1";
    nixpkgs-sheb = {
      url = "github:shebpamm/nixpkgs-sheb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    spicetify.url = "github:Gerg-L/spicetify-nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    zen.url = "github:0xc000022070/zen-browser-flake";
  };
}
