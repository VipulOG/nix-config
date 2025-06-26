{config, ...}: let
  colors =
    if config.custom.misc.stylix.enable
    then config.lib.stylix.colors.withHashtag
    else config.custom.common.vars.colorScheme.scheme.withHashtag;

  cursor =
    if config.custom.misc.stylix.enable
    then {inherit (config.stylix.cursor) name size;}
    else {inherit (config.custom.common.vars.cursor) name size;};
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
      xcursor-size ${toString cursor.size}
    }
  ''
