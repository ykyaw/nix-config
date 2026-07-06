{
  allowedUnfreePackages = [
    "discord"
    "spotify"
  ];

  flake.modules.homeManager.apps = { pkgs, ... }: {
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
