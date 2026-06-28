{
  flake.modules.nixos.users = {
    users.mutableUsers = false;

    security.sudo.configFile = ''
      Defaults insults
      Defaults lecture=never
    '';
  };
}
