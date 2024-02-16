{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      alderaan = nixpkgs.lib.nixosSystem {
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
