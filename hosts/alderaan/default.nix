{ config, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    inputs.impermanence.nixosModules.impermanence

    ../shared/nix.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "alderaan";

  time.timeZone = "Asia/Singapore";

  services = {
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      displayManager.defaultSession = "none+i3";
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
        ];
      };
    };
    zram-generator = {
      enable = true;
      settings.zram0.zram-size = 8192;
    };
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      initialPassword = "password11";
      extraGroups = [ "wheel" ];
      packages = with pkgs; [
        git
        ncdu
        neovim
        nixpkgs-fmt
      ];
    };
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  programs.dconf.enable = true;

  services.openssh.enable = true;

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "23.11";
}
