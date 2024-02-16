{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    nixos-hardware.url = github:NixOS/nixos-hardware;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations = {
      alderaan = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
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
