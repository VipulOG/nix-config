#kdl
''
  window-rule {
    open-maximized true
    geometry-corner-radius 0.0 0.0 0.0 0.0
    clip-to-geometry true
  }

  window-rule {
    match at-startup=true app-id="com.mitchellh.ghostty"
    open-on-workspace "code"
  }

  window-rule {
    match at-startup=true app-id="^zen(-beta)?$"
    open-on-workspace "web"
  }

  window-rule {
    match at-startup=true app-id="^brave-web.whatsapp.com"
    open-on-workspace "chat"
  }

  window-rule {
    match at-startup=true app-id="app.btop"
    open-on-workspace "system-monitor"
  }

  window-rule {
    match app-id="app.clipse"
    open-floating true
  }
''
