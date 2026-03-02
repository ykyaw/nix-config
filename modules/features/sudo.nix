{
  flake.modules.nixos.sudo = {
    security.sudo.configFile = ''
      Defaults insults
      Defaults lecture=never
    '';
  };
}
