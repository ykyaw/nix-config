{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../shared
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

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
    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 15;
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
          { app = "${pkgs.brave}/Applications/Brave Browser.app"; }
          { app = "/Applications/Microsoft Outlook.app"; }
          { app = "/Applications/Ghostty.app"; }
          { app = "${pkgs.vscode}/Applications/Visual Studio Code.app"; }
          { app = "${pkgs.postman}/Applications/Postman.app"; }
          { app = "${pkgs.dbeaver-bin}/Applications/dbeaver.app"; }
          { app = "${pkgs.gitkraken}/Applications/GitKraken.app"; }
          { app = "/Applications/Microsoft Teams.app"; }
          { app = "${pkgs.spotify}/Applications/Spotify.app"; }
        ];
        persistent-others = [
          "/Users/thatoe/Downloads"
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
}
