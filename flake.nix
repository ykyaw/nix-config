{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      alderaan = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/alderaan
        ];
      };
    };
  };
}
