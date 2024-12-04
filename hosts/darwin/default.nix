{ config, self, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;
  };

  users.users.thatoe = {
    name = "thatoe";
    home = "/Users/thatoe";
  };

  homebrew = {
    enable = true;
    casks = [
      "android-studio"
      "caffeine"
      "docker"
      "eloston-chromium"
      "flutter"
      "intune-company-portal"
      "microsoft-auto-update"
      "microsoft-teams"
    ];
    masApps = {
      Xcode = 497799835;
    };
    global.autoUpdate = false;
    onActivation.cleanup = "zap";
    taps = builtins.attrNames config.nix-homebrew.taps;
  };
}
