{
  programs.vscode = {
    enable = true;
    userSettings = {
      "[javascript]"."editor.defaultFormatter" = "dbaeumer.vscode-eslint";
      "[javascriptreact]"."editor.defaultFormatter" = "dbaeumer.vscode-eslint";
      "[jsonc]"."editor.defaultFormatter" = "vscode.json-language-features";
      "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
      "catppuccin.accentColor" = "teal";
      "catppuccin.colorOverrides"."mocha" = {
        "base" = "#000000";
        "mantle" = "#010101";
        "crust" = "#020202";
      };
      "editor.codeActionsOnSave"."source.fixAll.eslint" = "explicit";
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.fontFamily" = "monospace";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.rulers" = [ 150 ];
      "editor.tabSize" = 2;
      "git.autofetch" = true;
      "git.enableCommitSigning" = true;
      "prettier.printWidth" = 150;
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "workbench.startupEditor" = "none";
      "window.menuBarVisibility" = "toggle";
    };
  };
}
