{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      impermanence,
      home-manager,
      ...
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
            common-gpu-nvidia-nonprime
          ]
          ++ [
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.thatoe = import ./home/nixos;
              };
            }
            ./hosts/nixos
          ];
      };
    };
}
