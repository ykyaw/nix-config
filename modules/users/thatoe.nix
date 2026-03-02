{ inputs, ... }:
let
  username = "thatoe";
in
{
  flake.modules = {
    nixos."${username}" = {
      users.users."${username}" = {
        description = "Ye Thatoe Kyaw";
        isNormalUser = true;
        initialHashedPassword = "$y$j9T$lDwpaQZ/o0gUWs7it7bAM.$BxG4FDm/4aGnHYldH.M.0WopE4yaVDvi3W.wE2uVDQ7";
        extraGroups = [ "wheel" ];
      };

      home-manager.users."${username}".imports = with inputs.self.modules.homeManager; [
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

    homeManager."${username}".home = {
      inherit username;
      homeDirectory = "/home/${username}";
    };
  };
}
