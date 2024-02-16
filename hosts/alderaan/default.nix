{ config, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    inputs.impermanence.nixosModules.impermanence
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "alderaan";

  time.timeZone = "Asia/Singapore";

  services.xserver = {
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
    pulseaudio.enable = true;
  };

  sound.enable = true;

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      initialPassword = "password11";
      extraGroups = [ "wheel" ];
      packages = with pkgs; [
        brave
        git
        ncdu
        neovim
        nixpkgs-fmt
        vscode
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

  services.openssh.enable = true;

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "23.11";
}
