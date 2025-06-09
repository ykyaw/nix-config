{
  description = "NixOS and nix-darwin configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      impermanence,
      nix-darwin,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      home-manager,
      ...
    }:

    {
      nixosConfigurations.zanarkand = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.thatoe = import ./home/nixos/home.nix;
            };
          }
          ./hosts/nixos/configuration.nix
        ];
      };

      darwinConfigurations.macalania = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = "thatoe";
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };
              mutableTaps = false;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.thatoe = import ./home/darwin/home.nix;
            };
          }
          ./hosts/darwin/configuration.nix
        ];
      };
    };
}
