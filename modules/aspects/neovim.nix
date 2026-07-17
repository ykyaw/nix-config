{ den, ... }: {
  den.aspects.thatoe.includes = [ den.aspects.neovim ];

  den.aspects.neovim.homeManager = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
