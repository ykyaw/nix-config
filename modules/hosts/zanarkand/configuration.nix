{ inputs, ... }:
let
  hostName = "zanarkand";
in
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos hostName;

  flake.modules.nixos.${hostName} = {
    imports = with inputs.self.modules.nixos; [
      nix
      boot
      impermanence
      locale
      display-manager
      niri
      fonts
      networking
      audio
      firefox
      gaming
      docker
      users
      home
      unfree # Keeping track of unfree packages to hopefully find free alternatives.
    ];

    networking = { inherit hostName; };

    system.stateVersion = "26.05";
  };
}
