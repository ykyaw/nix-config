{ osConfig, vars, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "/home/${vars.username}/.config/sops/age/keys.txt";

    secrets = {
      ssh_key = {
        path = "/home/${vars.username}/.ssh/id_ed25519";
        mode = "0600";
      };
      npmrc = {
        path = "/home/${vars.username}/.npmrc";
        mode = "0600";
      };
    };
  };

  home.file.".ssh/id_ed25519.pub".source = ../../hosts/${osConfig.networking.hostName}/id_ed25519.pub;
}
