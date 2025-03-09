{ config, pkgs, ... }:

{
  home = {
    stateVersion = "24.11";
    packages = with pkgs; [
      azure-cli
      dbeaver-bin
      ghostscript
      gitkraken
      lens
      nixd
      nixfmt-rfc-style
      nodejs_20
      pnpm
      postgresql
      postman
      redis
      spotify
    ];
    sessionVariables = {
      CHROME_EXECUTABLE = "${pkgs.brave}/bin/brave";
    };
  };

  programs = {
    home-manager.enable = true;
    chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden Password Manager
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube - Skip Sponsorships
        "hipekcciheckooncpjeljhnekcoolahp" # Tabliss - A Beautiful New Tab
      ];
    };
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
        signByDefault = true;
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };
      extraConfig = {
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
        };
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
          "editor.fontFamily" = "Comic Code Ligatures";
          "editor.fontLigatures" = true;
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.lineNumbers" = "relative";
          "editor.minimap.enabled" = false;
          "editor.rulers" = [ 80 ];
          "editor.tabSize" = 2;
          "extensions.ignoreRecommendations" = true;
          "git.enableCommitSigning" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "telemetry.telemetryLevel" = "off";
          "terminal.integrated.defaultProfile.linux" = "fish";
          "terminal.integrated.defaultProfile.osx" = "fish";
          "workbench.colorTheme" = "Tokyo Night";
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.startupEditor" = "none";
        };
      };
    };
    zoxide.enable = true;
  };
}
