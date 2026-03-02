{
  flake.modules.homeManager.apps =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        discord
        teams-for-linux
      ];
    };
}
