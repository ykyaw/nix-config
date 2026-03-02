{
  flake.modules.homeManager.terminal =
    { config, ... }:
    {
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
        starship = {
          enable = true;
          settings.add_newline = false;
        };
        zoxide.enable = true;
      };
    };
}
