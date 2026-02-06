{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.zanarkand = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };
  };
}