{ den, inputs, ... }: {
  den.aspects.thatoe.includes = [ den.aspects.sops ];

  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.sops =
    let
      defaultSopsFile = ../../secrets/secrets.yaml;
    in
    {
      nixos = {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        sops = {
          inherit defaultSopsFile;
          secrets.user-password.neededForUsers = true;
        };
      };

      homeManager = {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        sops = {
          inherit defaultSopsFile;
          age.keyFile = ".config/sops/age/keys.txt";
          secrets = {
            ssh-key.path = ".ssh/id_ed25519";
            npmrc.path = ".npmrc";
          };
        };
      };
    };
}
