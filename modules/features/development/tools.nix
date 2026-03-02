{
  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bruno
        dbeaver-bin
      ];
    };
}
