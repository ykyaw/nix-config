{ den, ... }: {
  den.aspects.nixos-desktop.includes = [ den.aspects.fonts ];

  den.aspects.fonts.nixos = { pkgs, ... }: {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        noto-fonts
        noto-fonts-color-emoji
      ];
      fontconfig.defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Berkeley Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
