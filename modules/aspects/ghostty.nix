{ den, ... }: {
  den.aspects.thatoe.includes = [ den.aspects.ghostty ];

  den.aspects.ghostty.homeManager = {
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = "Berkeley Mono";
        theme = "Catppuccin Mocha";
      };
    };
  };
}
