{
  flake.modules.nixos.locale = {
    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_GB.UTF-8";
  };
}
