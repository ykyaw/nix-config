{
  config,
  pkgs,
  self,
  ...
}:

{
  nix = {
    settings.experimental-features = "nix-command flakes";
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
    optimise = {
      automatic = true;
      interval = {
        Weekday = 1;
        Hour = 0;
        Minute = 0;
      };
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
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
          "/Applications/Cursor.app"
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

  users.users.thatoe = {
    name = "thatoe";
    home = "/Users/thatoe";
    shell = pkgs.fish;
  };

  environment = {
    shells = [ pkgs.fish ];
    variables = {
      CHROME_EXECUTABLE = "/Applications/Chromium.app/Contents/MacOS/Chromium";
    };
  };

  programs.fish.enable = true;

  fonts.packages = [ pkgs.nerd-fonts.comic-shanns-mono ];

  homebrew = {
    enable = true;
    casks = [
      "android-studio"
      "caffeine"
      "cursor"
      "docker"
      "eloston-chromium"
      "flutter"
      "intune-company-portal"
      "microsoft-auto-update"
      "microsoft-teams"
    ];
    global.autoUpdate = false;
    onActivation.cleanup = "zap";
    taps = builtins.attrNames config.nix-homebrew.taps;
  };
}
