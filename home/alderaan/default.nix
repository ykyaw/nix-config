{ config, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = /home/${config.home.username};
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
