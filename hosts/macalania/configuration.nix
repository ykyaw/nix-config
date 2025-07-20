{ config, self, ... }:

{
  imports = [
    ../../modules/fonts.nix
    ../../modules/nix.nix
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
    brews = [ ];
    casks = [ ];
    masApps = {
      Xcode = 497799835;
    };
    global.autoUpdate = false;
    greedyCasks = true;
    onActivation.cleanup = "zap";
    taps = builtins.attrNames config.nix-homebrew.taps;
  };
}
