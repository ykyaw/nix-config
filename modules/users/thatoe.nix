{ config, inputs, ... }:
let
  username = config.username;
  fullName = config.fullName;
in
{
  flake.modules = {
    nixos."${username}" =
      { config, ... }:
      {
        users.users."${username}" = {
          description = fullName;
          isNormalUser = true;
          hashedPasswordFile = config.sops.secrets.password.path;
          extraGroups = [ "wheel" ];
        };

        sops.secrets.password.neededForUsers = true;

        home-manager.users."${username}".imports = with inputs.self.modules.homeManager; [
          base
          gnome
          theming
          browsers
          terminal
          development
          editors
          media
          apps
        ];
      };

    homeManager."${username}".home = {
      inherit username;
      homeDirectory = "/home/${username}";
    };
  };
}
