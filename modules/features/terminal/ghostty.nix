{
  flake.modules.homeManager.terminal =
    {
      lib,
      osConfig,
      pkgs,
      ...
    }:
    {
      programs.ghostty = {
        enable = true;
        settings = {
          command = "${lib.getExe pkgs.fish} --login --interactive";
          font-family = builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.monospace 0;
          theme = "Catppuccin Mocha";
        };
      };
    };
}
