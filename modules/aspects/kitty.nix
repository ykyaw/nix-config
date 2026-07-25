{
  flake.modules.homeManager.workstation = {
    programs.kitty = {
      enable = true;
      font.name = "Berkeley Mono";
      settings = {
        background_blur = 16;
        background_opacity = 0.9;
      };
      themeFile = "Catppuccin-Mocha";
    };
  };
}
