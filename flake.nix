{
  description = "NixOS and nix-darwin configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    {
      self,
      nixpkgs,
      nixos-hardware,
      lanzaboote,
      impermanence,
      nix-darwin,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      home-manager,
    }:

    {
      nixosConfigurations.zanarkand = nixpkgs.lib.nixosSystem {
        modules =
          with nixos-hardware.nixosModules;
          [
            common-pc
            common-pc-ssd
            common-cpu-amd
            common-cpu-amd-pstate
            common-gpu-amd
          ]
          ++ [
            lanzaboote.nixosModules.lanzaboote
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.thatoe = import ./home/nixos.nix;
              };
            }
            ./hosts/zanarkand/configuration.nix
          ];
      };

      darwinConfigurations.macalania = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self; };
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
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
              users.thatoe = import ./home/darwin.nix;
            };
          }
          ./hosts/macalania/configuration.nix
        ];

      };
    };
}
