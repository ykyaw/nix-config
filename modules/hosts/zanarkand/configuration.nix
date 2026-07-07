{ config, inputs, ... }:
let
  hostName = "zanarkand";
in
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos hostName;

  flake.modules.nixos.${hostName} = {
    imports = with inputs.self.modules.nixos; [
      boot
      nix
      unfree
      impermanence
      btrbk
      users
      home-manager
      networking
      ssh
      sops
      locale
      audio
      fonts
      gnome
      firefox
      docker
      gaming
    ];

    networking = { inherit hostName; };

    home-manager.users.${config.username} = {
      imports = with inputs.self.modules.homeManager; [
        home-manager
        sops
        themes
        shell
        direnv
        git
        neovim
        ghostty
        vscodium
        ai
        apps
      ];

      home.stateVersion = "26.05";
    };

    system.stateVersion = "26.05";
  };
}
