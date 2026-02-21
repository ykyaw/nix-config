{ constants, ... }:

{
  programs.kitty = {
    enable = true;
    font.name = constants.monospace;
    settings = {
      shell = "fish";
      background_opacity = 0.9;
      background_blur = 16;
    };
    themeFile = "Catppuccin-Mocha";
  };
}
