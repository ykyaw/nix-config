{ pkgs, ... }:

{
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };

  hardware.xone.enable = true;
}
