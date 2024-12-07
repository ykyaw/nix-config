{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

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
    openssh.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
        ];
      };
    };
  };

  hardware.nvidia.open = true;

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      hashedPassword = "$y$j9T$VZoA75eKJ68pcNpc15q5E0$kCzu1GKw8sINYrHwdmyYExsKjAP1b36lED6.fFTwEg2";
      extraGroups = [ "wheel" ];
      packages = with pkgs; [
        brave
        git
        ncdu
        neovim
        nixd
        nixfmt-rfc-style
        vscode
      ];
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

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.05";
}
