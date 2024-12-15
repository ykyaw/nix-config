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

  zramSwap = {
    enable = true;
    memoryPercent = 25;
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

  security.pam.services.lightdm.enableGnomeKeyring = true;

  services = {
    displayManager.defaultSession = "none+i3";
    gnome.gnome-keyring.enable = true;
    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
    };
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
      screenSection = ''
        Option "metamodes" "3840x2160_120 +0+0"
      '';
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

  programs.fish.enable = true;

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      hashedPassword = "$y$j9T$0ZrzA.r1YI4LhvzNltoJH.$3NcX7NDj3lar9hLn7VsJvHk8SDf5JulhMnZhagb.yO2";
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
      packages = with pkgs; [
        ncdu
        neovim
      ];
    };
  };

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      liberation_ttf
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-extra
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Comic Code Ligatures" ];
      };
      subpixel.rgba = "rgb";
      cache32Bit = true;
    };
  };

  system.stateVersion = "24.05";
}
