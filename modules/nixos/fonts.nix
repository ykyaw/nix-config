{ pkgs, vars, ... }:

{
  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      fira-code
      inter
      liberation_ttf
      noto-fonts
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ vars.defaultMonoFont ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  environment.sessionVariables.FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
}
