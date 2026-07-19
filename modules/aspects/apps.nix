{
  allowedUnfreePackages = [
    "android-studio"
    "discord"
    "spotify"
  ];

  flake.modules.homeManager.nixos-desktop = { pkgs, ... }: {
    home.packages = with pkgs; [
      android-studio
      bruno
      dbeaver-bin
      discord
      libreoffice
      qbittorrent
      spotify
      teams-for-linux
    ];
  };
}
