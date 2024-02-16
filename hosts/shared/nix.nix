{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
    gc = {
      options = "--delete-older-than +5";
      dates = "weekly";
      automatic = true;
    };
  };
}
