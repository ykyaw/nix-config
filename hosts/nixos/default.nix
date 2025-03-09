{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than-30d";
    };
    optimise.automatic = true;
    settings.experimental-features = "nix-command flakes";
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd"
      # TODO: home impermanence
      {
        directory = "/home/thatoe";
        user = "thatoe";
        group = "users";
        mode = "700";
      }
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  networking = {
    hostName = "zanarkand";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Singapore";

  services = {
    openssh.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  hardware.nvidia.open = true;

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      initialHashedPassword = "$y$j9T$Zf/t2ot4OWXkczm1vXNSq.$5u2yhmD5XKzoKmIxsX0QtDtT/LSVQS15jiIFWGUVMK7";
      extraGroups = [ "wheel" ];
      packages = with pkgs; [
        brave
        git
        ncdu
        neovim
        vscode
      ];
    };
  };

  system.stateVersion = "24.11";
}
