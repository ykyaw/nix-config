{ den, ... }: {
  den.aspects.nixos-desktop.includes = [ den.aspects.locale ];

  den.aspects.locale.nixos = {
    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_GB.UTF-8";
  };
}
