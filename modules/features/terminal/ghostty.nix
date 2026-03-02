{ config, ... }:
{
  flake.modules.homeManager.terminal =
    { lib, pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        settings = {
          command = "${lib.getExe pkgs.fish} --login --interactive";
          font-family = config.monospace;
          theme = "Catppuccin Mocha";
        };
      };
    };
}
