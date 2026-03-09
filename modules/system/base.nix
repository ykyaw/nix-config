{ inputs, self, ... }:
let
  base = {
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
  };
in
{
  flake.modules.nixos.base = base // {
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

    time.timeZone = "Asia/Singapore";

    system.stateVersion = "25.11";
  };

  flake.modules.darwin.base = base // {
    imports = with inputs.self.modules.darwin; [
      home-manager
    ];

    system = {
      configurationRevision = self.rev or self.dirtyRev or null;
      stateVersion = 6;
    };
  };
}
