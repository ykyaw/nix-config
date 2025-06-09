{ config, pkgs, ... }:

{
  home = {
    stateVersion = "25.05";
    packages = with pkgs; [
      azure-cli
      bruno
      dbeaver-bin
      gitkraken
      lens
      nixd
      nixfmt-rfc-style
      nodejs
      pnpm
      spotify
      valkey
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
    firefox.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
    };
    fzf.enable = true;
    git = {
      enable = true;
      userEmail = "thatoe@pm.me";
      userName = "Ye Thatoe Kyaw";
      signing = {
        format = "ssh";
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
      extraConfig = {
        gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
        push.autoSetupRemote = true;
        tag.forceSignAnnotated = true;
      };
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
    vscode = {
      enable = true;
      profiles.default = {
        enableUpdateCheck = false;
        userSettings = {
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.lineNumbers" = "relative";
          "editor.rulers" = [ 80 ];
          "editor.tabSize" = 2;
          "extensions.ignoreRecommendations" = true;
          "git.enableCommitSigning" = true;
          "github.copilot.nextEditSuggestions.enabled" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "telemetry.telemetryLevel" = "off";
          "terminal.integrated.defaultProfile.linux" = "fish";
          "workbench.colorTheme" = "Gruvbox Dark Hard";
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.startupEditor" = "none";
        };
      };
    };
    zoxide.enable = true;
  };
}
