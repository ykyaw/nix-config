{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../shared/configuration.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    stateVersion = 6;
    primaryUser = "thatoe";
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
          { app = "${pkgs.firefox}/Applications/Firefox.app"; }
          { app = "/Applications/Microsoft Outlook.app"; }
          { app = "${pkgs.alacritty}/Applications/Alacritty.app"; }
          { app = "${pkgs.vscode}/Applications/Visual Studio Code.app"; }
          { app = "${pkgs.gitkraken}/Applications/GitKraken.app"; }
          { app = "${pkgs.dbeaver-bin}/Applications/dbeaver.app"; }
          { app = "${pkgs.bruno}/Applications/Bruno.app"; }
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
