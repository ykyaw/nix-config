{ config, ... }:
{
  flake.modules.homeManager.terminal = {
    programs.kitty = {
      enable = true;
      font.name = config.monospace;
      themeFile = "Catppuccin-Mocha";
      settings = {
        shell = "fish";
        background_opacity = 0.9;
        background_blur = 10;
        cursor_trail = 1;
      };
    };
  };
}
