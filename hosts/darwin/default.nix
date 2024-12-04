{
  config,
  pkgs,
  self,
  ...
}:

{
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

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
  };

  programs.fish.enable = true;

  fonts.packages = [ pkgs.fira-code-nerdfont ];

  users = {
    knownUsers = [ "thatoe" ];
    users.thatoe = {
      uid = 501;
      name = "thatoe";
      home = "/Users/thatoe";
      shell = pkgs.fish;
    };
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
