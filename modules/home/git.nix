{
  flake.modules.homeManager.dev = { config, pkgs, ... }: {
    programs = {
      git = {
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
    };

    home.file.".ssh/id_ed25519.pub".source = ../../keys/id_ed25519.pub;

    home.packages = [ pkgs.lazygit ];
  };
}
