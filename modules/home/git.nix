{ vars, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = vars.fullName;
        email = vars.email;
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
