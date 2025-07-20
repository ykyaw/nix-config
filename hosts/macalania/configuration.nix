{
  config,
  pkgs,
  self,
  ...
}:

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
    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 25;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSWindowShouldDragOnGesture = true;
      };
      dock = {
        autohide = true;
        mru-spaces = false;
        persistent-apps = [
          "${pkgs.brave}/Applications/Brave Browser.app"
          "${pkgs.ghostty-bin}/Applications/Ghostty.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
          "${pkgs.dbeaver-bin}/Applications/dbeaver.app"
          "/Applications/Microsoft Teams.app"
          "${pkgs.spotify}/Applications/Spotify.app"
        ];
        persistent-others = [
          "${config.users.users.thatoe.home}/Downloads"
        ];
        show-recents = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        QuitMenuItem = true;
        ShowPathbar = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
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
