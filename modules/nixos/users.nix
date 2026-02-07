{ config, vars, ... }:

{
  users = {
    mutableUsers = false;
    users.${vars.username} = {
      description = vars.fullName;
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.user_password.path;
      extraGroups = [ "wheel" ];
    };
  };

  security.sudo.configFile = ''
    Defaults insults
    Defaults lecture=never
  '';
}
