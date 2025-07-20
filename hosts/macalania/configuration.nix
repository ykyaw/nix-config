{ self, ... }:

{
  imports = [
    ../../modules/fonts.nix
    ../../modules/nix.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
  };
}
