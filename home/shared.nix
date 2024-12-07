{ config, pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = if pkgs.stdenv.isLinux then "/home/thatoe" else "/Users/thatoe";
    stateVersion = "24.05";
    packages = with pkgs; [
      azure-cli
      dbeaver-bin
      gitkraken
      kubectl
      nixd
      nixfmt-rfc-style
      nodejs_20
      spotify
      vscode
    ];
  };

  programs = {
    home-manager.enable = true;
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
    fish = {
      enable = true;
      functions.fish_greeting = "";
      interactiveShellInit = "fish_vi_key_bindings";
      shellAliases = {
        ns =
          (if pkgs.stdenv.isLinux then "sudo nixos" else "darwin")
          + "-rebuild switch --flake ~/development/nix-config";
        nu = "nix flake update --flake ~/development/nix-config";
      };
    };
    fzf.enable = true;
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
    kitty = {
      enable = true;
      font.name = "FiraCode Nerd Font";
      settings = {
        background_opacity = 0.9;
        background_blur = 32;
        window_margin_width = 5;
      };
      themeFile = "Nord";
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
