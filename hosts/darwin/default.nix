{
  config,
  pkgs,
  self,
  ...
}:

{
  imports = [
    ../shared.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;
    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 25;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
      dock = {
        autohide = true;
        mru-spaces = false;
        persistent-apps = [
          "${pkgs.brave}/Applications/Brave Browser.app"
          "/Applications/Chromium.app"
          "/Applications/Microsoft Outlook.app"
          "${pkgs.kitty}/Applications/kitty.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
          "${pkgs.gitkraken}/Applications/GitKraken.app"
          "${pkgs.dbeaver-bin}/Applications/DBeaver.app"
          "/Applications/Microsoft Teams.app"
          "${pkgs.spotify}/Applications/Spotify.app"
        ];
        persistent-others = [
          "/Users/thatoe/Downloads"
        ];
        show-recents = false;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  users = {
    knownUsers = [ "thatoe" ];
    users.thatoe = {
      uid = 501;
      name = "thatoe";
      home = "/Users/thatoe";
    };
  };

  environment.variables = {
    CHROME_EXECUTABLE = "/Applications/Chromium.app/Contents/MacOS/Chromium";
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
      "microsoft-azure-storage-explorer"
      "microsoft-outlook"
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
