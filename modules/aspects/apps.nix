{ den, ... }: {
  den.aspects.nixos-desktop.includes = [ den.aspects.apps ];

  den.aspects.apps = {
    includes = [
      (den.batteries.unfree [
        "android-studio"
        "discord"
        "spotify"
      ])
    ];

    provides.to-users.homeManager = { pkgs, ... }: {
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
  };
}
