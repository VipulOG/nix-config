{config, ...}: let
  colors =
    if builtins.hasAttr "stylix" config.lib
    then config.lib.stylix.colors.withHashtag
    else config.custom.common.constants.colorScheme.withHashtag;

  cursor = {
    name = config.stylix.cursor.name or null;
    size = toString config.stylix.cursor.size or null;
  };
in
  #kdl
  ''
    layout {
      gaps 10
      struts {
        left 0
        right 0
        top 0
        bottom 0
      }
      focus-ring {
        off
      }

      border {
        width 4
        active-color "${colors.base0D}"
        inactive-color "${colors.base03}"
      }

      shadow {
        on
        offset x=0 y=0
        softness 8
        spread 4
        draw-behind-window false
        color "#00000070"
      }

      tab-indicator {
        gap 4
        width 10
        length total-proportion=0.5
        position "bottom"
        gaps-between-tabs 4
        corner-radius 0
      }

      insert-hint {
        color "rgb(127 200 255 / 50%)"
      }

      default-column-width
      center-focused-column "never"
    }

    cursor {
      xcursor-theme "${cursor.name}"
      xcursor-size ${cursor.size}
    }
  ''
