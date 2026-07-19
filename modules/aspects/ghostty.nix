{
  flake.modules.homeManager.workstation = {
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = "Berkeley Mono";
        theme = "Catppuccin Mocha";
      };
    };
  };
}
