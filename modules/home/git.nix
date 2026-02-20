{ constants, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = constants.fullName;
        email = constants.email;
      };
      push.autoSetupRemote = true;
    };
    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };
}
