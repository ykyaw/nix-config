{
  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        azure-cli
        bruno
        dbeaver-bin
        lens
        postgresql
      ];
    };
}
