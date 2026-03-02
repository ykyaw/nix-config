{
  flake.modules.nixos.gaming =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      hardware.xone.enable = true;

      environment.systemPackages = [ pkgs.xclicker ];
    };
}
