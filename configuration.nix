{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys = {
        enable = true;
        autoReboot = true;
      };
    };
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      config.boot.lanzaboote.pkiBundle
      "/etc/NetworkManager/system-connections"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/var/log"
    ];
    files = [ "/etc/machine-id" ];
  };

  networking = {
    hostName = "zanarkand";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Singapore";

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
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
  };

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      fira-code
      inter
      liberation_ttf
      noto-fonts
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "Berkeley Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  environment.sessionVariables.FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      initialHashedPassword = "$y$j9T$3UjVg6hThDHLRSGmLaClK1$IXMQenpZ1gauv4gJLRJOyHz.u466VhVfIFyBONYnhe5";
      extraGroups = [ "wheel" ];
      packages = with pkgs; [
        brave
        neovim
      ];
    };
  };

  system.stateVersion = "25.11";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.thatoe = ./home.nix;
  };
}
