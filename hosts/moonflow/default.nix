{
  imports = [
    ./hardware.nix
    ../../modules/nixos
    ../../modules/home
  ];

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "moonflow";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Singapore";

  services = {
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
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

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
      }
    ];
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  system.stateVersion = "25.11";
}
