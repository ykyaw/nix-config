{ pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
      azure-cli
      dbeaver-bin
      gitkraken
      kubectl
      nixd
      nixfmt-rfc-style
      nodejs_20
      spotify
      vscode
    ]
    ++ (
      if pkgs.stdenv.isLinux then
        [
          dejavu_fonts
          dex
          discord
          docker
          docker-compose
          dunst
          fish
          fzf
          ghostscript
          git
          gnome-keyring
          graphicsmagick
          inter
          kitty
          liberation_ttf
          maim
          mpv
          ncdu
          nemo
          nemo-fileroller
          neovim
          netcat-gnu
          noto-fonts
          numlockx
          pavucontrol
          playerctl
          polkit_gnome
          postgresql
          qbittorrent
          redis
          ripgrep
          rofi
          starship
          steam
          teams-for-linux
          udiskie
          ungoogled-chromium
          xclip
          xdotool
          zoxide
        ]
      else
        [
          cocoapods
          raycast
        ]
    );

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions =
      [
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden Password Manager
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube - Skip Sponsorships
      ]
      ++ (
        if pkgs.stdenv.isLinux then
          [
            { id = "dnhpnfgdlenaccegplpojghhmaamnnfp"; } # Augmented Steam
            { id = "ngonfifpkpeefnhelnfdkficaiihklid"; } # ProtonDB for Steam
            { id = "kdbmhfkmnlmbkgbabkdealhhbfhlmmon"; } # SteamDB
            { id = "lcbjdhceifofjlpecfpeimnnphbcjgnc"; } # xBrowserSync
          ]
        else
          [ ]
      );
  };
}
