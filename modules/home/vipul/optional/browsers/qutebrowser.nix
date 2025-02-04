{
  programs.qutebrowser = {
    enable = true;
    settings = {
      colors = {
        hints = {
          bg = "#000000";
          fg = "#ffffff";
        };
        tabs.bar.bg = "#000000";
      };
      tabs.tabs_are_windows = true;
      colors.webpage.preferred_color_scheme = "dark";
    };
  };
}
