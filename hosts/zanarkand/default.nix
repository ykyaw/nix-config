{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/nixos
    ../../modules/home
  ];

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "zanarkand";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Singapore";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs = {
    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  system.stateVersion = "25.11";
}
