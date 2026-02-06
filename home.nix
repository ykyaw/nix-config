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
    home-manager.enable = true;
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    zoxide.enable = true;
  };
}
