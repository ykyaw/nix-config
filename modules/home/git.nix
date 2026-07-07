{
  flake.modules.homeManager.git = { config, pkgs, ... }: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "thatoe@pm.me";
          name = "Ye Thatoe Kyaw";
        };
        push.autoSetupRemote = true;
      };
      signing = {
        format = "ssh";
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
    };

    home = {
      packages = [ pkgs.lazygit ];
      file.".ssh/id_ed25519.pub".source = ../../secrets/id_ed25519.pub;
    };
  };
}
