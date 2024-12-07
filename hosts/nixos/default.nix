{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "zanarkand";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Singapore";

  services = {
    displayManager.defaultSession = "none+i3";
    gnome.gnome-keyring.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3lock
        ];
      };
    };
  };

  security.pam.services.lightdm.enableGnomeKeyring = true;

  hardware.nvidia.open = true;

  zramSwap = {
    enable = true;
    memoryPercent = 10;
  };

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      hashedPassword = "$y$j9T$VZoA75eKJ68pcNpc15q5E0$kCzu1GKw8sINYrHwdmyYExsKjAP1b36lED6.fFTwEg2";
      extraGroups = [ "wheel" ];
    };
  };

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      # TODO: home impermanence
      {
        directory = "/home/thatoe";
        user = "thatoe";
        group = "users";
        mode = "0700";
      }
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  programs.dconf.enable = true;

  fonts.fontconfig = {
    enable = true;
    cache32Bit = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "FiraCode Nerd Font" ];
    };
  };

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.05";
}
