{
  allowedUnfreePackages = [
    "android-studio"
    "discord"
    "spotify"
  ];

  flake.modules.homeManager.apps = { pkgs, ... }: {
    home.packages = with pkgs; [
      android-studio
      bruno
      dbeaver-bin
      discord
      qbittorrent
      spotify
      teams-for-linux
    ];
  };
}
