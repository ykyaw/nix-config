{ inputs, ... }: {
  flake.modules.homeManager.sops =
    { config, ... }:
    let
      home = config.home.homeDirectory;
    in
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      sops = {
        defaultSopsFile = ../../secrets/secrets.yaml;
        age.keyFile = "${home}/.config/sops/age/keys.txt";
        secrets = {
          ssh-key.path = "${home}/.ssh/id_ed25519";
          npmrc.path = "${home}/.npmrc";
        };
      };
    };
}
