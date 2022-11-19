user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false); 
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false); 
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); 
user_pref("toolkit.telemetry.updatePing.enabled", false); 
user_pref("toolkit.telemetry.bhrPing.enabled", false); 
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false); 
user_pref("toolkit.telemetry.coverage.opt-out", true); 
user_pref("toolkit.coverage.opt-out", true); 
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("browser.ping-centre.telemetry", false);

user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false); 
   
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false); 

user_pref("network.captive-portal-service.enabled", false); 
user_pref("network.connectivity-service.enabled", false);
user_pref("trailhead.firstrun.didSeeAboutWelcome", true);

user_pref("browser.startup.page", 0);
user_pref("startup.homepage_welcome_url", "about:blank");
user_pref("datareporting.policy.firstRunURL", "");
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.preload", false);

user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);

user_pref("browser.contentblocking.category", "strict");
user_pref("network.cookie.cookieBehavior", 5);
user_pref("network.http.referer.disallowCrossSiteRelaxingDefault", true);
user_pref("privacy.annotate_channels.strict_list.enabled", true);
user_pref("privacy.partition.network_state.ocsp_cache", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

user_pref("extensions.pocket.enabled", false);
user_pref("general.autoScroll", true);

// Disable Ctrl+W
user_pref("extensions.dorandoKeyConfig.main.key_close", "!][][");

// Hide Youtube Age Restriction Bypass from toolbar
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"VimFxButton\",\"addon_darkreader_org-browser-action\",\"ublock0_raymondhill_net-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"VimFxButton\",\"simple-youtube-age-restriction-bypass_zerody_one-browser-action\",\"addon_darkreader_org-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"developer-button\",\"sponsorblocker_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\"],\"currentVersion\":17,\"newElementCount\":2}");

// Allow extensions to run on sites like support.mozilla.com
user_pref("extensions.webextensions.restrictedDomains", "");

// Prevent address bar from recommending shitty websites
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.pinned", "[]");
user_pref("browser.search.hiddenOneOffs", "Amazon.fr,Bing");
user_pref("browser.urlbar.suggest.topsites", false);

user_pref("network.IDN_show_punycode", true);

user_pref("privacy.userContext.enabled", true);
user_pref("privacy.userContext.newTabContainerOnLeftClick.enabled", true);
user_pref("privacy.userContext.ui.enabled", true);

user_pref("browser.tabs.firefox-view", false);

// https://github.com/akhodakivskiy/VimFx/blob/master/documentation/config-file.md
user_pref("extensions.VimFx.config_file_directory", "/firefox/.vimfx/");
// This only works in hardened-firefox.
user_pref("security.sandbox.content.read_path_whitelist", "/firefox/.vimfx/");
user_pref("extensions.VimFx.prevent_autofocus", true);
user_pref("extensions.VimFx.mode.normal.scroll_page_down", "<c-f>");
user_pref("extensions.VimFx.mode.normal.scroll_page_up", "<c-b>");

// To use the parent-process Browser console
user_pref("devtools.chrome.enabled", true);
