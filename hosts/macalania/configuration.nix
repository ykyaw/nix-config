{ config, self, ... }:

{
  imports = [
    ../../modules/fonts.nix
    ../../modules/nix.nix
    ../../modules/services.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
    primaryUser = "thatoe";
  };

  users.users.thatoe.home = "/Users/thatoe";

  homebrew = {
    enable = true;
    casks = [
      "android-studio"
      # TODO: install bruno from nixpkgs once darwin build is fixed
      "bruno"
      "caffeine"
      {
        name = "flutter";
        greedy = false;
      }
      "intune-company-portal"
      "microsoft-excel"
      "microsoft-outlook"
      "microsoft-teams"
      "microsoft-word"
      "orbstack"
    ];
    masApps = {
      Xcode = 497799835;
    };
    global.autoUpdate = false;
    greedyCasks = true;
    onActivation.cleanup = "zap";
    taps = builtins.attrNames config.nix-homebrew.taps;
  };
}
