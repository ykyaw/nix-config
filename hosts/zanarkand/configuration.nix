{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/fonts.nix
    ../../modules/nix.nix
  ];

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
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
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
    ];
    files = [ "/etc/machine-id" ];
  };

  networking = {
    hostName = "zanarkand";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Singapore";

  services = {
    gnome.gnome-keyring.enable = true;
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
    udisks2.enable = true;
  };

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      initialHashedPassword = "$y$j9T$2DqEl.piVsbd1h0QMpfFi0$bG06DaWBPUoJWadmH09GoXI546Z3xPTNXQuZfBh1ooC";
      extraGroups = [ "wheel" ];
    };
  };

  security = {
    polkit.enable = true;
    sudo.configFile = ''
      Defaults insults
      Defaults lecture=never
    '';
  };

  programs = {
    dconf.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif" ];
    sansSerif = [ "Noto Sans" ];
    monospace = [ "Fira Code" ];
    emoji = [ "Noto Color Emoji" ];
  };

  system.stateVersion = "25.05";
}
