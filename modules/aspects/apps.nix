{
  allowedUnfreePackages = [
    "discord"
    "discord-unwrapped"
    "spotify"
  ];

  flake.modules.homeManager.workstation = { pkgs, ... }: {
    home.packages = with pkgs; [
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
