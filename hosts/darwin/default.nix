{
  config,
  pkgs,
  self,
  ...
}:

{
  environment.systemPackages = [
    pkgs.vim
  ];

  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
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
      "cursor"
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
