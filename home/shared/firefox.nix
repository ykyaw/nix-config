{
  programs.firefox = {
    enable = true;
    profiles.default.settings = {
      "app.shield.optoutstudies.enabled" = false;
      "browser.download.useDownloadDir" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.startup.page" = 3;
      "datareporting.healthreport.uploadEnabled" = false;
      "doh-rollout.disable-heuristics" = true;
      "dom.security.https_only_mode" = true;
      "dom.security.https_only_mode_ever_enabled" = true;
      "general.autoScroll" = true;
      "media.eme.enabled" = true;
      "network.trr.mode" = 2;
      "signon.rememberSignons" = false;
    };
  };
}
