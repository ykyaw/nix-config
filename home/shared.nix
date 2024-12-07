{ config, pkgs, ... }:

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
          dex
          discord
          docker
          docker-compose
          dunst
          fish
          fzf
          ghostscript
          gnome-keyring
          graphicsmagick
          kitty
          maim
          mpv
          ncdu
          nemo
          nemo-fileroller
          neovim
          netcat-gnu
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

  programs = {
    chromium = {
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
    git = {
      enable = true;
      userName = "Ye Thatoe Kyaw";
      userEmail = "thatoe@pm.me";
      signing = {
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
      extraConfig = {
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
        };
        push.autoSetupRemote = true;
      };
    };
  };
}
