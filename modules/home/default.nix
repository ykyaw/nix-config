{ pkgs, vars, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${vars.username} = {
      imports = [
        ./brave.nix
        ./ghostty.nix
        ./git.nix
        ./gnome.nix
        ./neovim.nix
        ./shell.nix
        ./vscode.nix
      ];

      programs.home-manager.enable = true;

      home = {
        username = vars.username;
        homeDirectory = "/home/${vars.username}";
        packages = with pkgs; [
          bruno
          claude-code
          dbeaver-bin
          discord
          lazygit
          libreoffice-fresh
          ncdu
          qbittorrent
          spotify
          teams-for-linux
          xclicker
          yazi
        ];
      };

      gtk = {
        enable = true;
        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };

      home.pointerCursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;
        gtk.enable = true;
      };

      home.stateVersion = "25.11";
    };
  };

}
