{
  flake.modules.nixos.unfree = {
    allowedUnfreePackages = [
      "steam"
      "steam-unwrapped"
    ];
  };

  flake.modules.nixos.gaming =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      environment.systemPackages = [ pkgs.xclicker ];
    };
}
