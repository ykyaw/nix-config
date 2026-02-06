{
  lib,
  pkgs,
  vars,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    settings = {
      command = "${lib.getExe pkgs.fish} --login --interactive";
      font-family = vars.defaultMonoFont;
      theme = "Catppuccin Mocha";
    };
  };
}
