{ config, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "thatoe@pm.me";
    userName = "Ye Thatoe Kyaw";
    signing = {
      signByDefault = true;
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    };
    extraConfig = {
      gpg.format = "ssh";
    };
  };
}
