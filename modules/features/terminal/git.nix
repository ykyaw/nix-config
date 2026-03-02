{ config, ... }:
let
  name = config.fullName;
in
{
  flake.modules.homeManager.terminal =
    { config, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            email = "thatoe@pm.me";
            inherit name;
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
}
