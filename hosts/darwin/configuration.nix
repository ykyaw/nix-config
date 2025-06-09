{ config, inputs, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    stateVersion = 6;
    primaryUser = "thatoe";
  };

  users.users.thatoe = {
    name = "thatoe";
    home = "/Users/thatoe";
  };

  environment.variables = {
    CHROME_EXECUTABLE = "chromium";
  };

  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      "android-studio"
      "caffeine"
      "chromium"
      "flutter"
      "intune-company-portal"
      "microsoft-excel"
      "microsoft-outlook"
      "microsoft-teams"
      "microsoft-word"
      "orbstack"
    ];
    masApps.Xcode = 497799835;
    taps = builtins.attrNames config.nix-homebrew.taps;
  };
}
