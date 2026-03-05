{
  flake.modules.homeManager.media = {
    programs.mpv = {
      enable = true;
      config = {
        profile = "high-quality";
        video-sync = "display-resample";
        interpolation = "yes";
      };
    };
  };
}
