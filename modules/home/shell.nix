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
          flakeDir = "~/development/nix-config";
        in
        {
          ns = "sudo nixos-rebuild switch --flake ${flakeDir}";
          nu = "nix flake update --flake ${flakeDir}";
        };
    };
    fzf.enable = true;
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    zoxide.enable = true;
  };
}
