{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    nixos-hardware.url = github:NixOS/nixos-hardware;

    impermanence.url = github:nix-community/impermanence;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "";
      };
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
    in
    {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        alderaan = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/alderaan
          ];
        };
      };

      homeConfigurations = {
        "thatoe@alderaan" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./home/alderaan
          ];
        };
      };
    };
}
