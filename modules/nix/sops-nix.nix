{ inputs, ... }:
{
  flake.modules.nixos.sops-nix =
    { config, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      sops = {
        defaultSopsFile = ../../secrets/secrets.yaml;
        age.sshKeyPaths = map (key: key.path) config.services.openssh.hostKeys;
      };
    };

  flake.modules.homeManager.sops-nix =
    { config, ... }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      sops = {
        defaultSopsFile = ../../secrets/secrets.yaml;
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    };
}
