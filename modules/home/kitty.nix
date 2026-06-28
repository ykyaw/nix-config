{
  flake.modules.homeManager.kitty = { lib, pkgs, ... }: {
    programs.kitty = {
      enable = true;
      font.name = "Berkeley Mono";
      settings = {
        background_blur = 16;
        background_opacity = 0.9;
        shell = lib.getExe pkgs.fish;
      };
      themeFile = "Catppuccin-Mocha";
    };
  };
}
