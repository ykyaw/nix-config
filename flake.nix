{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

  outputs =
    {
      nixpkgs,
      lanzaboote,
      impermanence,
      home-manager,
      ...
    }@inputs:

    let
      system = "x86_64-linux";
      vars = import ./vars.nix;
      pkgs = nixpkgs.legacyPackages.${system};

      mkHost =
        hostPath:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs vars; };
          modules = [
            lanzaboote.nixosModules.lanzaboote
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = { inherit vars; }; }
            hostPath
          ];
        };
    in
    {
      nixosConfigurations.zanarkand = mkHost ./hosts/zanarkand;

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nixfmt
        ];
      };
    };
}
