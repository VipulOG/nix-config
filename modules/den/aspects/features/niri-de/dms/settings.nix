{
  den.aspects.niri-de.dms.settings = {
    homeManager = {config, ...}: {
      programs.dank-material-shell = {
        settings = {
          barConfigs = [
            {
              centerWidgets = [
                "music"
                "clock"
                "weather"
              ];
              enabled = true;
              fontScale = 0.8;
              id = "default";
              innerPadding = 2;
              leftWidgets = [
                "launcherButton"
                "workspaceSwitcher"
                "focusedWindow"
              ];
              name = "Main Bar";
              openOnOverview = true;
              position = 2;
              rightWidgets = [
                "systemTray"
                "cpuUsage"
                "memUsage"
                "notificationButton"
                "battery"
                "controlCenterButton"
              ];
              spacing = 0;
              squareCorners = true;
              transparency = 0.9;
              visible = true;
              widgetOutlineColor = "surfaceText";
              widgetOutlineEnabled = true;
              widgetOutlineOpacity = 0.1;
              widgetPadding = 4;
            }
          ];
          blurEnabled = true;
          clockCompactMode = true;
          cornerRadius = 8;
          currentThemeCategory = "dynamic";
          currentThemeName = "dynamic";
          cursorSettings.niri.hideAfterInactiveMs = 0;
          cursorSettings.niri.hideWhenTyping = true;
          cursorSettings.size = 24;
          gtkThemingEnabled = true;
          launcherLogoMode = "os";
          lockBeforeSuspend = true;
          lockScreenPowerOffMonitorsOnLock = true;
          lockScreenShowDate = false;
          lockScreenShowPowerActions = false;
          lockScreenShowSystemIcons = false;
          lockScreenShowTime = false;
          matugenScheme = "scheme-content";
          niriLayoutGapsOverride = 8;
          notificationCompactMode = true;
          notificationOverlayEnabled = true;
          notificationPopupPosition = 1;
          osdPowerProfileEnabled = true;
          popupTransparency = 0.9;
          terminalsAlwaysDark = true;
          updaterHideWidget = true;
          useAutoLocation = true;
        };

        clipboardSettings = {
          maxHistory = 100;
          maxEntrySize = 5242880;
          autoClearDays = 0;
          clearAtStartup = false;
          disabled = false;
          maxPinned = 25;
        };
      };
    };
  };
}
