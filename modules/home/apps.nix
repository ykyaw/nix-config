{
  flake.modules.homeManager.apps = { pkgs, ... }: {
    allowedUnfreePackages = [
      "discord"
      "spotify"
    ];

    home.packages = with pkgs; [
      bruno
      dbeaver-bin
      discord
      qbittorrent
      spotify
      teams-for-linux
    ];
  };
}
