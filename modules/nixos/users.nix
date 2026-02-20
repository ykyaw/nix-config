{ constants, ... }:

{
  users = {
    mutableUsers = false;
    users.${constants.username} = {
      description = constants.fullName;
      isNormalUser = true;
      initialHashedPassword = "$y$j9T$3UjVg6hThDHLRSGmLaClK1$IXMQenpZ1gauv4gJLRJOyHz.u466VhVfIFyBONYnhe5";
      extraGroups = [ "wheel" ];
    };
  };

  security.sudo.configFile = ''
    Defaults insults
    Defaults lecture=never
  '';
}
