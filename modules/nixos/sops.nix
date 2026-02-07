{ vars, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/persist/${vars.hostKeyPath}" ];

    secrets.user_password.neededForUsers = true;
  };
}
