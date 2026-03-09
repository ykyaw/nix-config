{ inputs, ... }:
{
  flake.modules.nixos.base = {
    imports = with inputs.self.modules.nixos; [
      lanzaboote
      impermanence
      sops-nix
      home-manager
      btrbk
      sudo
      audio
      networking
      ssh
      fonts
      development
    ];

    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      };
      optimise.automatic = true;
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "Asia/Singapore";

    system.stateVersion = "25.11";
  };
}
