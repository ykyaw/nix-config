{ config, inputs, ... }:
{
  flake.modules = {
    nixos."${config.username}" = {
      users.users."${config.username}" = {
        description = config.fullName;
        isNormalUser = true;
        initialHashedPassword = "$y$j9T$lDwpaQZ/o0gUWs7it7bAM.$BxG4FDm/4aGnHYldH.M.0WopE4yaVDvi3W.wE2uVDQ7";
        extraGroups = [ "wheel" ];
      };

      home-manager.users."${config.username}".imports = with inputs.self.modules.homeManager; [
        base
        gnome
        theming
        browsers
        terminal
        development
        editors
        apps
      ];
    };

    homeManager."${config.username}".home = {
      username = config.username;
      homeDirectory = "/home/${config.username}";
    };
  };
}
