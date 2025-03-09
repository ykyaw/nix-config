{ inputs, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  users.users.thatoe = {
    name = "thatoe";
    home = "/Users/thatoe";
  };

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    stateVersion = 6;
  };
}
