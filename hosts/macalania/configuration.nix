{ self, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
  };
}
