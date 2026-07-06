{
  flake.modules.homeManager.ghostty = { lib, pkgs, ... }: {
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = "Berkeley Mono";
        theme = "Catppuccin Mocha";
        command = "${lib.getExe pkgs.fish} -li";
      };
    };
  };
}
