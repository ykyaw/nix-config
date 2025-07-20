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

  services.aerospace = {
    enable = true;
    settings = {
      enable-normalization-flatten-containers = false;
      enable-normalization-opposite-orientation-for-nested-containers = false;
      accordion-padding = 0;
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      mode.main.binding = {
        alt-enter = "exec-and-forget open -a Ghostty";
        alt-b = "exec-and-forget open -a 'Brave Browser'";
        alt-c = "exec-and-forget open -a 'Visual Studio Code'";

        alt-shift-q = "close";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-left = "focus left";
        alt-down = "focus down";
        alt-up = "focus up";
        alt-right = "focus right";

        alt-shift-j = "move left";
        alt-shift-k = "move down";
        alt-shift-l = "move right";
        alt-shift-h = "move left";

        alt-shift-left = "move left";
        alt-shift-down = "move down";
        alt-shift-up = "move up";
        alt-shift-right = "move right";

        alt-s = "layout v_accordion";
        alt-w = "layout h_accordion";
        alt-e = "layout tiles horizontal vertical";

        alt-f = "fullscreen";
        alt-shift-space = "layout floating tiling";

        alt-tab = "workspace-back-and-forth";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-0 = "workspace 10";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";
        alt-shift-0 = "move-node-to-workspace 10";

        alt-shift-c = "reload-config";

        alt-shift-s = "exec-and-forget screencapture -i -c";

        alt-r = "mode resize";
      };
      mode.resize.binding = {
        h = "resize width -50";
        j = "resize height +50";
        k = "resize height -50";
        l = "resize width +50";
        enter = "mode main";
        esc = "mode main";
      };
      on-window-detected = [
        {
          "if".app-id = "com.brave.Browser";
          run = [ "move-node-to-workspace 1" ];
        }
        {
          "if".app-id = "com.microsoft.VSCode";
          run = [ "move-node-to-workspace 2" ];
        }
        {
          "if".app-id = "org.jkiss.dbeaver.core.product";
          run = [ "move-node-to-workspace 3" ];
        }
        {
          "if".app-id = "com.usebruno.app";
          run = [ "move-node-to-workspace 3" ];
        }
        {
          "if".app-id = "net.novade.novadeLite";
          run = [ "move-node-to-workspace 3" ];
        }
        {
          "if".app-id = "com.microsoft.teams2";
          run = [ "move-node-to-workspace 4" ];
        }
        {
          "if".app-id = "com.spotify.client";
          run = [ "move-node-to-workspace 5" ];
        }
        {
          "if".app-id = "com.mitchellh.ghostty";
          run = [ "layout floating" ];
        }
      ];
      workspace-to-monitor-force-assignment = {
        "1" = "secondary";
        "3" = "secondary";
        "4" = "secondary";
      };
    };
  };

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
