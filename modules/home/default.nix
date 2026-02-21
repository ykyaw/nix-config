{ constants, pkgs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${constants.username} = {
      imports = [
        ./brave.nix
        ./direnv.nix
        ./ghostty.nix
        ./git.nix
        ./neovim.nix
        ./noctalia.nix
        ./shell.nix
        ./vscode.nix
      ];

      programs.home-manager.enable = true;

      home = {
        username = constants.username;
        homeDirectory = "/home/${constants.username}";
        packages = with pkgs; [
          bruno
          claude-code
          dbeaver-bin
          discord
          lazygit
          libreoffice-fresh
          nautilus
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
