{ config, inputs, ... }:
let
  username = config.username;
  fullName = config.fullName;
in
{
  flake.modules.nixos."${username}" =
    { config, ... }:
    {
      users.users."${username}" = {
        description = fullName;
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.user_password.path;
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [
          (builtins.readFile ./id_ed25519.pub)
        ];
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

  flake.modules.homeManager."${username}" = {
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
    };

    sops.secrets = {
      ssh_private_key = {
        path = "/home/${username}/.ssh/id_ed25519";
        mode = "0600";
      };
      npmrc = {
        path = "/home/${username}/.npmrc";
        mode = "0600";
      };
    };
  };
}
