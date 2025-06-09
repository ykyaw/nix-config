{ pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "25.05";
    packages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];
  };

  programs = {
    home-manager.enable = true;
    alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.9;
          blur = true;
        };
        terminal.shell = "fish";
      };
      theme = "gruvbox_dark";
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
      shellAliases =
        let
          flake = "/home/thatoe/develop/nix-config";
        in
        {
          ns = "sudo nixos-rebuild switch --flake ${flake}";
          nu = "nix flake update --flake ${flake}";
        };
    };
    fzf.enable = true;
    git = {
      enable = true;
      userEmail = "thatoe@pm.me";
      userName = "Ye Thatoe Kyaw";
      signing = {
        format = "ssh";
        key = "/home/thatoe/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
      extraConfig = {
        gpg.ssh.allowedSignersFile = "/home/thatoe/.ssh/allowed_signers";
        push.autoSetupRemote = true;
        tag.forceSignAnnotated = true;
      };
    };
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    zoxide.enable = true;
  };
}
