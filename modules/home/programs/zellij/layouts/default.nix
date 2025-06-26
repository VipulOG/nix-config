{
  config,
  inputs',
  ...
}: let
  pluginPath = "file://${inputs'.zjstatus.packages.default}/bin/zjstatus.wasm";
  inherit (config.custom.common.constants) timeZone;

  colors =
    if config.custom.misc.stylix.enable
    then config.lib.stylix.colors.withHashtag
    else config.custom.common.constants.colorScheme.withHashtag;
in
  # kdl
  ''
    layout {
      pane size=1 borderless=true {
        plugin location="${pluginPath}" {
          hide_frame_for_single_pane "true"
          format_left "{mode}#[fg=${colors.base05},bg=${colors.base01}] {session}#[bg=${colors.base01}] "
          format_right "{datetime}"
          format_center "{tabs}"
          format_space "#[bg=${colors.base01}]"
          mode_normal "#[fg=${colors.base01},bg=${colors.base0D},bold] "
          mode_default_to_mode_tmux "#[fg=${colors.base01},bg=${colors.base09},bold] "
          mode_locked "#[fg=${colors.base01},bg=${colors.base08},bold] "
          mode_resize "#[fg=${colors.base01},bg=${colors.base0A},bold] "
          mode_pane "#[fg=${colors.base01},bg=${colors.base0B},bold] "
          mode_tab "#[fg=${colors.base01},bg=${colors.base0C},bold] "
          mode_scroll "#[fg=${colors.base01},bg=${colors.base0E},bold] "
          mode_enter_search "#[fg=${colors.base01},bg=${colors.base0F},bold] "
          mode_search "#[fg=${colors.base01},bg=${colors.base0F},bold] "
          mode_rename_tab "#[fg=${colors.base01},bg=${colors.base0C},bold] "
          mode_rename_pane "#[fg=${colors.base01},bg=${colors.base0B},bold] "
          mode_session "#[fg=${colors.base01},bg=${colors.base06},bold] "
          mode_move "#[fg=${colors.base01},bg=${colors.base05},bold] "
          mode "tmux"
          tab_normal "#[fg=${colors.base03},bg=${colors.base01}] {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
          tab_active "#[fg=${colors.base05},bg=${colors.base01},bold] {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
          tab_fullscreen_indicator "□ "
          tab_sync_indicator "  "
          tab_floating_indicator "󰉈 "
          datetime "#[fg=${colors.base04},bg=${colors.base01}] {format} "
          datetime_format "%A, %d %b %Y %H:%M"
          datetime_timezone "${timeZone}"
          border_enabled "false"
          border_char "‾"
          border_format "#[fg=${colors.base02}]"
          border_position "bottom"
        }
      }
      pane split_direction="vertical" {
        pane
      }
    }
  ''
