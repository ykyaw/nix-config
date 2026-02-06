{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, impermanence, home-manager }:
  
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations.zanarkand = nixpkgs.lib.nixosSystem {
      modules = [
        impermanence.nixosModules.impermanence
        home-manager.nixosModules.home-manager
        ./configuration.nix
      ];
    };

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        nixd
        nixfmt
      ];
    };
  };
}