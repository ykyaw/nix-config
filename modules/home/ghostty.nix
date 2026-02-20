{
  constants,
  lib,
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    settings = {
      command = "${lib.getExe pkgs.fish} --login --interactive";
      font-family = constants.monospace;
      theme = "Catppuccin Mocha";
    };
  };
}
