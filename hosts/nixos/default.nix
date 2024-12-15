{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    settings.experimental-features = "nix-command flakes";
    optimise.automatic = true;
    gc = {
      options = "--delete-older-than 14d";
      automatic = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
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
    displayManager.defaultSession = "none+i3";
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

  hardware.nvidia.open = true;

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      hashedPassword = "$y$j9T$0ZrzA.r1YI4LhvzNltoJH.$3NcX7NDj3lar9hLn7VsJvHk8SDf5JulhMnZhagb.yO2";
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

  system.stateVersion = "24.05";
}
