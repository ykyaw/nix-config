{
  flake.modules.nixos.nixos-desktop = {
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

    programs.nix-ld.enable = true;
  };
}
