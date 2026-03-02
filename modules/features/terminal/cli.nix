{
  flake.modules.homeManager.terminal =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        btop
        claude-code
        lazydocker
        lazygit
        ncdu
        yazi
      ];
    };
}
