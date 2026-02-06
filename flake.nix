{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, impermanence }: {
    nixosConfigurations.zanarkand = nixpkgs.lib.nixosSystem {
      modules = [
        impermanence.nixosModules.impermanence
        ./configuration.nix
      ];
    };
  };
}