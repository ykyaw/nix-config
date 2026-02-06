{ pkgs, vars, ... }:

{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        dart-code.dart-code
        dart-code.flutter
        dbaeumer.vscode-eslint
        eamodio.gitlens
        esbenp.prettier-vscode
        firsttris.vscode-jest-runner
        github.copilot
        github.copilot-chat
        graphql.vscode-graphql
        graphql.vscode-graphql-syntax
        jnoortheen.nix-ide
        stkb.rewrap
        streetsidesoftware.code-spell-checker
        usernamehw.errorlens
        vscodevim.vim
      ];
      languageSnippets = {
        dart = {
          fontLoader = {
            prefix = "fontLoader";
            body = "await (FontLoader('Roboto')..addFont(rootBundle.load('assets/fonts/Roboto-Regular.ttf'))).load();";
            description = "Load the Roboto font for testing";
          };
          golden = {
            prefix = "golden";
            body = "await expectLater(find.byType(MaterialApp), matchesGoldenFile('golden/DO_NOT_COMMIT.png'));";
            description = "Add a golden test";
          };
        };
      };
      userSettings = {
        "editor.fontFamily" = vars.defaultMonoFont;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.rulers" = [ 80 ];
        "editor.tabSize" = 2;
        "extensions.ignoreRecommendations" = true;
        "git.enableCommitSigning" = true;
        "github.copilot.nextEditSuggestions.enabled" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "telemetry.feedback.enabled" = false;
        "telemetry.telemetryLevel" = "off";
        "terminal.integrated.defaultProfile.linux" = "fish";
        "vim.foldfix" = true;
        "vim.highlightedyank.enable" = true;
        "vim.leader" = "<space>";
        "vim.smartRelativeLine" = true;
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "workbench.startupEditor" = "none";
      };
    };
  };
}
