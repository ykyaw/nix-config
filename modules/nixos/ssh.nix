{ config, vars, ... }:

{
  services.openssh = {
    enable = true;
    hostKeys = [
      {
        path = vars.hostKeyPath;
        type = "ed25519";
      }
    ];
    knownHosts.${config.networking.hostName}.publicKeyFile =
      ../../hosts/${config.networking.hostName}/ssh_host_ed25519_key.pub;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  environment.persistence."/persist".files = [ vars.hostKeyPath ];
}
