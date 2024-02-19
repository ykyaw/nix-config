{ config, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    inputs.impermanence.nixosModules.impermanence
    inputs.sops-nix.nixosModules.sops

    ../shared/fish.nix
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
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      hostKeys = [
        {
          path = "/persist/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    udisks2.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        sddm.enable = true;
        defaultSession = "none+i3";
      };
      windowManager.i3.enable = true;
      excludePackages = [ pkgs.xterm ];
      monitorSection = ''
        Option "DPI" "96 x 96"
      '';
      screenSection = ''
        Option "metamodes" "3840x2160_120 +0+0"
      '';
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
      };
    };
    zram-generator = {
      enable = true;
      settings.zram0.zram-size = 8192;
    };
  };

  hardware.xone.enable = true;

  users = {
    mutableUsers = false;
    users.thatoe = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.password.path;
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
    };
  };

  security = {
    pam.services.login.enableKwallet = true;
    sudo.extraConfig = "Defaults lecture=never";
  };

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    secrets.password.neededForUsers = true;
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

  programs = {
    dconf.enable = true;
    steam.enable = true;
  };

  fonts = {
    fontconfig = {
      enable = true;
      cache32Bit = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "MonaspiceAr NFM" ];
      };
    };
    packages = with pkgs; [
      dejavu_fonts
      inter
      liberation_ttf
      noto-fonts
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "Monaspace" ]; })
    ];
  };

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "23.11";
}
