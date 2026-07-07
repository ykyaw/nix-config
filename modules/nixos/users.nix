let
  username = "thatoe";
in
{
  inherit username;

  flake.modules.nixos.users = { config, ... }: {
    users = {
      mutableUsers = false;
      users.${username} = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.user-password.path;
        extraGroups = [ "wheel" ];
      };
    };

    security.sudo.configFile = ''
      Defaults insults
      Defaults lecture=never
    '';
  };
}
