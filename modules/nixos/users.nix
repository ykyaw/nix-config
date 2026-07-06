{ config, ... }: {
  username = "thatoe";

  flake.modules.nixos.users = {
    users = {
      mutableUsers = false;
      users.${config.username} = {
        isNormalUser = true;
        hashedPasswordFile = "/persist/password";
        extraGroups = [ "wheel" ];
      };
    };

    security.sudo.configFile = ''
      Defaults insults
      Defaults lecture=never
    '';
  };
}
