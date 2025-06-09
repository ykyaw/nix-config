{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared/configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
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
        mode = "0700";
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
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
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
          i3status
          i3lock
        ];
      };
    };
  };

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      initialHashedPassword = "$y$j9T$gfPywz6CpSQo2e6pol9eA/$93.eDhru.iYKOFSdJK1N8oYq5st1nagp0c3X.pJR4bD";
      extraGroups = [ "wheel" ];
    };
  };

  programs = {
    dconf.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      fira-code
      inter
      liberation_ttf
      noto-fonts
      noto-fonts-extra
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "Fira Code" ];
    };
  };

  system.stateVersion = "25.05";
}
