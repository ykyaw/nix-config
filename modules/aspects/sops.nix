{ inputs, ... }: {
  flake.modules.nixos.workstation = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      secrets.user-password.neededForUsers = true;
    };
  };

  flake.modules.homeManager.workstation = {
    imports = [ inputs.sops-nix.homeManagerModules.sops ];

    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      age.keyFile = ".config/sops/age/keys.txt";
      secrets = {
        ssh-key.path = ".ssh/id_ed25519";
        npmrc.path = ".npmrc";
      };
    };
  };
}
