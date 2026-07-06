{
  flake.modules.homeManager.shell = { config, pkgs, ... }: {
    programs = {
      fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
          fish_vi_key_bindings
        '';
        shellAliases =
          let
            flake = "${config.home.homeDirectory}/Projects/nix-config";
          in
          {
            ns = "nixos-rebuild switch --sudo --flake ${flake}";
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

    home.packages = with pkgs; [
      ncdu
      yazi
    ];
  };
}
