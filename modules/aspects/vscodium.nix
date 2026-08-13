{
  allowedUnfreePackages = [ "vscode-extension-anthropic-claude-code" ];

  flake.modules.homeManager.workstation =
    { lib, pkgs, ... }:
    let
      # https://redirect.github.com/prettier/prettier-vscode/issues/3931
      prettier = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "prettier-vscode";
          publisher = "esbenp";
          version = "11.0.3";
          hash = "sha256-qWbHLWZOA40XpNAZ2hovPo8IzsTYjMENI5NY/7qfupk=";
        };
      };

      # "<leader>ff" -> [ "<leader>" "f" "f" ], keeping <...> tokens intact.
      toKeys =
        key:
        lib.concatMap (part: if lib.isList part then part else lib.stringToCharacters part) (
          builtins.split "(<[^>]+>)" key
        );

      # Turn { "<leader>ff" = "workbench.action.quickOpen"; } into VSCodeVim bindings.
      # A value is a command, a list of commands, or a raw binding attrset (for `after`).
      mkBindings = lib.mapAttrsToList (
        key: value:
        { before = toKeys key; } // (if lib.isAttrs value then value else { commands = lib.toList value; })
      );

      # https://www.lazyvim.org/keymaps
      normalBindings = {
        # General
        "<esc>" = ":nohl";
        "<C-s>" = "workbench.action.files.save";
        "<leader><space>" = "workbench.action.quickOpen";
        "<leader>," = "workbench.action.showAllEditorsByMostRecentlyUsed";
        "<leader>." = "workbench.action.files.newUntitledFile";
        "<leader>/" = "workbench.action.findInFiles";
        "<leader>:" = "workbench.action.showCommands";
        "<leader>?" = "workbench.action.openGlobalKeybindings";
        "<leader>n" = "notifications.showList";

        # Buffers
        "H" = "workbench.action.previousEditor";
        "L" = "workbench.action.nextEditor";
        "[b" = "workbench.action.previousEditor";
        "]b" = "workbench.action.nextEditor";
        "<leader>`" = "workbench.action.openPreviousRecentlyUsedEditorInGroup";
        "<leader>bb" = "workbench.action.openPreviousRecentlyUsedEditorInGroup";
        "<leader>bd" = "workbench.action.closeActiveEditor";
        "<leader>bD" = "workbench.action.closeEditorsAndGroup";
        "<leader>bj" = "workbench.action.showAllEditors";
        "<leader>bl" = "workbench.action.closeEditorsToTheLeft";
        "<leader>bo" = "workbench.action.closeOtherEditors";
        "<leader>bp" = "workbench.action.pinEditor";
        "<leader>bP" = "workbench.action.closeUnpinnedEditors";
        "<leader>br" = "workbench.action.closeEditorsToTheRight";

        # Windows
        "<leader>-" = "workbench.action.splitEditorDown";
        "<leader>|" = "workbench.action.splitEditorRight";
        "<leader>wd" = "workbench.action.closeEditorsAndGroup";
        "<leader>wm" = "workbench.action.toggleMaximizeEditorGroup";

        # Code / LSP
        "gd" = "editor.action.revealDefinition";
        "gD" = "editor.action.revealDeclaration";
        "gI" = "editor.action.goToImplementation";
        "gK" = "editor.action.triggerParameterHints";
        "gr" = "editor.action.goToReferences";
        "gy" = "editor.action.goToTypeDefinition";
        "K" = "editor.action.showHover";
        "[[" = "editor.action.wordHighlight.prev";
        "]]" = "editor.action.wordHighlight.next";
        "<leader>ca" = "editor.action.quickFix";
        "<leader>cA" = "editor.action.sourceAction";
        "<leader>cd" = "editor.action.showHover";
        "<leader>cf" = "editor.action.formatDocument";
        "<leader>co" = "editor.action.organizeImports";
        "<leader>cr" = "editor.action.rename";
        "<leader>cs" = "workbench.action.gotoSymbol";
        "<leader>cS" = "editor.action.goToReferences";

        # Diagnostics / quickfix
        "[d" = "editor.action.marker.prev";
        "]d" = "editor.action.marker.next";
        "[e" = "editor.action.marker.prevInFiles";
        "]e" = "editor.action.marker.nextInFiles";
        "[q" = "editor.action.marker.prevInFiles";
        "]q" = "editor.action.marker.nextInFiles";
        "[w" = "editor.action.marker.prevInFiles";
        "]w" = "editor.action.marker.nextInFiles";
        "<leader>xx" = "workbench.actions.view.problems";
        "<leader>xX" = "workbench.actions.view.problems";

        # Files / explorer / terminal
        "<leader>e" = "workbench.view.explorer";
        "<leader>E" = "workbench.view.explorer";
        "<leader>fb" = "workbench.action.showAllEditors";
        "<leader>fe" = "workbench.view.explorer";
        "<leader>fE" = "workbench.view.explorer";
        "<leader>ff" = "workbench.action.quickOpen";
        "<leader>fF" = "workbench.action.quickOpen";
        "<leader>fg" = "workbench.action.quickOpen";
        "<leader>fn" = "workbench.action.files.newUntitledFile";
        "<leader>fp" = "workbench.action.openRecent";
        "<leader>fr" = "workbench.action.openRecent";
        "<leader>ft" = "workbench.action.terminal.toggleTerminal";
        "<leader>fT" = "workbench.action.terminal.new";

        # Search
        "<leader>sb" = "actions.find";
        "<leader>sc" = "workbench.action.showCommands";
        "<leader>sC" = "workbench.action.showCommands";
        "<leader>sd" = "workbench.actions.view.problems";
        "<leader>sD" = "workbench.action.showErrorsWarnings";
        "<leader>sg" = "workbench.action.findInFiles";
        "<leader>sG" = "workbench.action.findInFiles";
        "<leader>sk" = "workbench.action.openGlobalKeybindings";
        "<leader>sr" = "editor.action.startFindReplaceAction";
        "<leader>ss" = "workbench.action.gotoSymbol";
        "<leader>sS" = "workbench.action.showAllSymbols";
        "<leader>st" = "workbench.action.findInFiles";
        "<leader>sw" = "workbench.action.findInFiles";
        "<leader>sW" = "workbench.action.findInFiles";

        # Git
        "[h" = "workbench.action.editor.previousChange";
        "]h" = "workbench.action.editor.nextChange";
        "<leader>gb" = "gitlens.toggleLineBlame";
        "<leader>gB" = "gitlens.openFileOnRemote";
        "<leader>gd" = "gitlens.diffWithPrevious";
        "<leader>gf" = "gitlens.showQuickFileHistory";
        "<leader>gg" = "workbench.view.scm";
        "<leader>gl" = "gitlens.showQuickRepoHistory";
        "<leader>gL" = "gitlens.showQuickRepoHistory";
        "<leader>gs" = "workbench.view.scm";
        "<leader>gY" = "gitlens.copyRemoteFileUrlToClipboard";

        # Toggles
        "<leader>ub" = "workbench.action.toggleLightDarkThemes";
        "<leader>uC" = "workbench.action.selectTheme";
        "<leader>ud" = "errorLens.toggle";
        "<leader>ui" = "editor.action.inspectTMScopes";
        "<leader>un" = "notifications.clearAll";
        "<leader>ur" = ":nohl";
        "<leader>us" = "cSpell.toggleEnableSpellChecker";
        "<leader>uw" = "editor.action.toggleWordWrap";
        "<leader>uz" = "workbench.action.toggleZenMode";
        "<leader>uZ" = "workbench.action.toggleMaximizeEditorGroup";

        # Tests
        "<leader>td" = "testing.debugAtCursor";
        "<leader>tl" = "testing.reRunLastRun";
        "<leader>to" = "testing.showMostRecentOutput";
        "<leader>tr" = "testing.runAtCursor";
        "<leader>ts" = "workbench.view.testing";
        "<leader>tS" = "testing.cancelRun";
        "<leader>tt" = "testing.runCurrentFile";
        "<leader>tT" = "testing.runAll";

        # Debug
        "<leader>da" = "workbench.action.debug.start";
        "<leader>db" = "editor.debug.action.toggleBreakpoint";
        "<leader>dB" = "editor.debug.action.conditionalBreakpoint";
        "<leader>dc" = "workbench.action.debug.continue";
        "<leader>dC" = "editor.debug.action.runToCursor";
        "<leader>di" = "workbench.action.debug.stepInto";
        "<leader>dl" = "workbench.action.debug.restart";
        "<leader>do" = "workbench.action.debug.stepOut";
        "<leader>dO" = "workbench.action.debug.stepOver";
        "<leader>dP" = "workbench.action.debug.pause";
        "<leader>dr" = "workbench.debug.action.toggleRepl";
        "<leader>dt" = "workbench.action.debug.stop";
        "<leader>du" = "workbench.view.debug";

        # AI (claudecode.nvim equivalents)
        "<leader>aa" = "claude-vscode.acceptProposedDiff";
        "<leader>ab" = "claude-vscode.insertAtMention";
        "<leader>ac" = "claude-vscode.toggleFocusView";
        "<leader>ad" = "claude-vscode.rejectProposedDiff";
        "<leader>af" = "claude-vscode.focus";
        "<leader>an" = "claude-vscode.newConversation";
        "<leader>ar" = "claude-vscode.reopenClosedSession";
        "<leader>as" = "claude-vscode.insertAtMention";

        # Quit / session
        "<leader>ql" = "workbench.action.reopenClosedEditor";
        "<leader>qq" = "workbench.action.closeWindow";
      };

      visualBindings = {
        "<C-s>" = "workbench.action.files.save";
        "<" = {
          after = [
            "<"
            "g"
            "v"
          ];
        };
        ">" = {
          after = [
            ">"
            "g"
            "v"
          ];
        };
        "<leader>as" = "claude-vscode.insertAtMention";
        "<leader>ca" = "editor.action.quickFix";
        "<leader>cf" = "editor.action.formatSelection";
        "<leader>de" = "editor.debug.action.selectionToRepl";
        "<leader>gB" = "gitlens.openFileOnRemote";
        "<leader>gY" = "gitlens.copyRemoteFileUrlToClipboard";
        "<leader>sr" = "editor.action.startFindReplaceAction";
        "<leader>sw" = "workbench.action.findInFiles";
        "<leader>sW" = "workbench.action.findInFiles";
      };

      insertBindings = {
        "<C-s>" = "workbench.action.files.save";
      };
    in
    {
      programs.vscodium = {
        enable = true;
        mutableExtensionsDir = false;
        profiles.default = {
          enableMcpIntegration = true;
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          extensions =
            with pkgs.vscode-extensions;
            [
              anthropic.claude-code
              catppuccin.catppuccin-vsc
              catppuccin.catppuccin-vsc-icons
              dart-code.dart-code
              dart-code.flutter
              dbaeumer.vscode-eslint
              eamodio.gitlens
              firsttris.vscode-jest-runner
              graphql.vscode-graphql
              graphql.vscode-graphql-syntax
              jnoortheen.nix-ide
              mkhl.direnv
              stkb.rewrap
              streetsidesoftware.code-spell-checker
              usernamehw.errorlens
              vscodevim.vim
            ]
            ++ [ prettier ];
          # Keys VSCodeVim cannot own: they must also work outside the editor, or in
          # modes where the vim extension does not see them.
          keybindings = [
            # <C-h/j/k/l> window navigation
            {
              key = "ctrl+h";
              command = "workbench.action.focusLeftGroup";
              when = "!editorTextFocus || vim.mode != 'Insert'";
            }
            {
              key = "ctrl+j";
              command = "workbench.action.focusBelowGroup";
              when = "!editorTextFocus || vim.mode != 'Insert'";
            }
            {
              key = "ctrl+k";
              command = "workbench.action.focusAboveGroup";
              when = "!editorTextFocus || vim.mode != 'Insert'";
            }
            {
              key = "ctrl+l";
              command = "workbench.action.focusRightGroup";
              when = "!editorTextFocus || vim.mode != 'Insert'";
            }
            # <C-k> is signature help in insert mode
            {
              key = "ctrl+k";
              command = "editor.action.triggerParameterHints";
              when = "editorTextFocus && vim.mode == 'Insert'";
            }
            # <C-Arrow> window resizing
            {
              key = "ctrl+up";
              command = "workbench.action.increaseViewHeight";
              when = "vim.mode == 'Normal'";
            }
            {
              key = "ctrl+down";
              command = "workbench.action.decreaseViewHeight";
              when = "vim.mode == 'Normal'";
            }
            {
              key = "ctrl+left";
              command = "workbench.action.decreaseViewWidth";
              when = "vim.mode == 'Normal'";
            }
            {
              key = "ctrl+right";
              command = "workbench.action.increaseViewWidth";
              when = "vim.mode == 'Normal'";
            }
            # <A-j>/<A-k> move lines, in every mode
            {
              key = "alt+j";
              command = "editor.action.moveLinesDownAction";
              when = "editorTextFocus && !editorReadonly";
            }
            {
              key = "alt+k";
              command = "editor.action.moveLinesUpAction";
              when = "editorTextFocus && !editorReadonly";
            }
            # Leader keys that have to work while the explorer holds focus
            {
              key = "space e";
              command = "workbench.action.focusActiveEditorGroup";
              when = "filesExplorerFocus && !inputFocus";
            }
            {
              key = "space space";
              command = "workbench.action.quickOpen";
              when = "filesExplorerFocus && !inputFocus";
            }
          ];
          languageSnippets = {
            dart = {
              fontLoader = {
                prefix = "fontLoader";
                description = "Load the Roboto font for testing";
                body = "await (FontLoader('Roboto')..addFont(rootBundle.load('assets/fonts/Roboto-Regular.ttf'))).load();";
              };
              golden = {
                prefix = "golden";
                description = "Add a golden test";
                body = "await expectLater(find.byType(MaterialApp), matchesGoldenFile('golden/DO_NOT_COMMIT.png'));";
              };
            };
          };
          userSettings = {
            "[dart]"."editor.rulers" = [ 160 ];
            "[typescript]"."editor.rulers" = [ 140 ];
            "claudeCode.preferredLocation" = "sidebar";
            "editor.cursorSurroundingLines" = 4;
            "editor.fontFamily" = "Berkeley Mono";
            "editor.fontLigatures" = true;
            "editor.formatOnPaste" = true;
            "editor.formatOnSave" = true;
            "editor.minimap.enabled" = false;
            "editor.tabSize" = 2;
            "extensions.ignoreRecommendations" = true;
            "git.enableCommitSigning" = true;
            "gitlens.plusFeatures.enabled" = false;
            "gitlens.rebaseEditor.openOnPausedRebase" = false;
            "gitlens.telemetry.enabled" = false;
            "nix.enableLanguageServer" = true;
            "terminal.integrated.initialHint" = false;
            "vim.foldfix" = true;
            # Handled by keybindings.json above so they work outside the editor too.
            "vim.handleKeys" = {
              "<C-h>" = false;
              "<C-j>" = false;
              "<C-k>" = false;
              "<C-l>" = false;
            };
            "vim.highlightedyank.enable" = true;
            "vim.hlsearch" = true;
            "vim.insertModeKeyBindingsNonRecursive" = mkBindings insertBindings;
            "vim.leader" = "<space>";
            "vim.normalModeKeyBindingsNonRecursive" = mkBindings normalBindings;
            "vim.smartRelativeLine" = true;
            # Closest thing to flash.nvim's `s`/`S` that does not clash with <leader><space>.
            "vim.sneak" = true;
            "vim.sneakUseIgnorecaseAndSmartcase" = true;
            "vim.useSystemClipboard" = true;
            "vim.visualModeKeyBindingsNonRecursive" = mkBindings visualBindings;
            "workbench.colorTheme" = "Catppuccin Mocha";
            "workbench.iconTheme" = "catppuccin-mocha";
            "workbench.startupEditor" = "none";
          };
        };
      };
    };
}
