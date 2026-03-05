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
}
