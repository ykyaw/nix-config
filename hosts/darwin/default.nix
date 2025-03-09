{ config, inputs, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      "openjdk@17"
    ];
    casks = [
      "android-studio"
      "caffeine"
      "flutter"
      "ghostty"
      "intune-company-portal"
      "microsoft-auto-update"
      "microsoft-excel"
      "microsoft-outlook"
      "microsoft-teams"
      "microsoft-word"
      "orbstack"
    ];
    masApps.Xcode = 497799835;
    taps = builtins.attrNames config.nix-homebrew.taps;
  };

  users.users.thatoe = {
    name = "thatoe";
    home = "/Users/thatoe";
  };

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    stateVersion = 6;
  };
}
