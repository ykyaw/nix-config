{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "25.11";
  };

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
      shellAliases =
        let
          flake = "${config.home.homeDirectory}/development/nix-config";
        in
        {
          ns = "sudo nixos-rebuild switch --flake ${flake}";
          nu = "nix flake update --flake ${flake}";
        };
    };
    fzf.enable = true;
    ghostty = {
      enable = true;
      settings = {
        command = "${lib.getExe pkgs.fish} --login --interactive";
        font-family = builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.monospace 0;
        theme = "Catppuccin Mocha";
      };
    };
    git = {
      enable = true;
      settings = {
        user = {
          email = "thatoe@pm.me";
          name = "Ye Thatoe Kyaw";
        };
        push.autoSetupRemote = true;
      };
      signing = {
        format = "ssh";
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
    };
    home-manager.enable = true;
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    zoxide.enable = true;
  };
}
