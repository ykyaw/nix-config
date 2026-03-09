{ config, inputs, ... }:
let
  username = config.username;
  userConfig = {
    description = config.fullName;
    openssh.authorizedKeys.keys = [ (builtins.readFile ./id_ed25519.pub) ];
  };
in
{
  flake.modules.nixos."${username}" =
    { config, ... }:
    {
      users.users."${username}" = userConfig // {
        home = "/home/${username}";
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.user_password.path;
        extraGroups = [ "wheel" ];
      };

      sops.secrets.user_password.neededForUsers = true;

      home-manager.users."${username}".imports =
        with inputs.self.modules.homeManager;
        [
          base
          sops-nix
          gnome
          theming
          browsers
          terminal
          development
          editors
          media
          apps
        ]
        ++ [ inputs.self.modules.homeManager.${username} ];
    };

  flake.modules.darwin."${username}" = {
    users.users."${username}" = userConfig // {
      home = "/Users/${username}";
    };

    home-manager.users."${username}".imports =
      with inputs.self.modules.homeManager;
      [
        base
        sops-nix
        browsers
        terminal
        development
        editors
        apps
      ]
      ++ [ inputs.self.modules.homeManager.${username} ];
  };

  flake.modules.homeManager."${username}" =
    { config, osConfig, ... }:
    {
      home = {
        inherit username;
        homeDirectory = osConfig.users.users."${username}".home;
      };

      sops.secrets = {
        ssh_private_key = {
          path = "${config.home.homeDirectory}/.ssh/id_ed25519";
          mode = "0600";
        };
        npmrc = {
          path = "${config.home.homeDirectory}/.npmrc";
          mode = "0600";
        };
      };
    };
}
