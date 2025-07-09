{
  lib,
  config,
  ...
}: let
  themeLib = import ../theme/lib.nix {inherit lib;};
  colors = themeLib.color.base16Colors config;
  inherit (themeLib.color) darken;
in {
  config.vim = {
    tabline.nvimBufferline = {
      enable = true;

      setupOpts = {
        highlights = let
          # Base colors
          defaultBg = darken colors.base01 0.12;
          selectedBg = colors.base00;
          defaultFg = colors.base04;
          selectedFg = colors.base06;

          # Diagnostic colors
          hintColor = colors.base0C;
          infoColor = colors.base0D;
          warningColor = colors.base0A;
          errorColor = colors.base08;

          # Other colors
          separatorColor = colors.base02;
          offsetColor = selectedBg;
          indicatorColor = infoColor;
          modifiedColor = colors.base0A;
          pickColor = colors.base0E;
        in {
          fill = {
            fg = defaultFg;
            bg = defaultBg;
          };
          background = {
            fg = defaultFg;
            bg = defaultBg;
          };
          tab = {
            fg = defaultFg;
            bg = defaultBg;
          };
          tab_selected = {
            fg = selectedFg;
            bg = selectedBg;
          };
          tab_separator = {
            fg = separatorColor;
            bg = defaultBg;
          };
          tab_separator_selected = {
            fg = separatorColor;
            bg = selectedBg;
            sp = indicatorColor;
            underline = false;
          };
          tab_close = {
            fg = errorColor;
            bg = defaultBg;
          };
          close_button = {
            fg = errorColor;
            bg = defaultBg;
          };
          close_button_visible = {
            fg = errorColor;
            bg = defaultBg;
          };
          close_button_selected = {
            fg = errorColor;
            bg = selectedBg;
          };
          buffer_visible = {
            fg = defaultFg;
            bg = defaultBg;
          };
          buffer_selected = {
            fg = selectedFg;
            bg = selectedBg;
            bold = true;
            italic = false;
          };
          numbers = {
            fg = defaultFg;
            bg = defaultBg;
          };
          numbers_visible = {
            fg = defaultFg;
            bg = defaultBg;
          };
          numbers_selected = {
            fg = selectedFg;
            bg = selectedBg;
            bold = true;
            italic = false;
          };
          diagnostic = {
            fg = defaultFg;
            bg = defaultBg;
          };
          diagnostic_visible = {
            fg = defaultFg;
            bg = defaultBg;
          };
          diagnostic_selected = {
            fg = selectedFg;
            bg = selectedBg;
            bold = true;
            italic = false;
          };
          hint = {
            fg = hintColor;
            sp = hintColor;
            bg = defaultBg;
          };
          hint_visible = {
            fg = hintColor;
            bg = defaultBg;
          };
          hint_selected = {
            fg = hintColor;
            bg = selectedBg;
            sp = hintColor;
            bold = true;
            italic = false;
          };
          hint_diagnostic = {
            fg = hintColor;
            sp = hintColor;
            bg = defaultBg;
          };
          hint_diagnostic_visible = {
            fg = hintColor;
            bg = defaultBg;
          };
          hint_diagnostic_selected = {
            fg = hintColor;
            bg = selectedBg;
            sp = hintColor;
            bold = true;
            italic = false;
          };
          info = {
            fg = infoColor;
            sp = infoColor;
            bg = defaultBg;
          };
          info_visible = {
            fg = infoColor;
            bg = defaultBg;
          };
          info_selected = {
            fg = infoColor;
            bg = selectedBg;
            sp = infoColor;
            bold = true;
            italic = false;
          };
          info_diagnostic = {
            fg = infoColor;
            sp = infoColor;
            bg = defaultBg;
          };
          info_diagnostic_visible = {
            fg = infoColor;
            bg = defaultBg;
          };
          info_diagnostic_selected = {
            fg = infoColor;
            bg = selectedBg;
            sp = infoColor;
            bold = true;
            italic = false;
          };
          warning = {
            fg = warningColor;
            sp = warningColor;
            bg = defaultBg;
          };
          warning_visible = {
            fg = warningColor;
            bg = defaultBg;
          };
          warning_selected = {
            fg = warningColor;
            bg = selectedBg;
            sp = warningColor;
            bold = true;
            italic = false;
          };
          warning_diagnostic = {
            fg = warningColor;
            sp = warningColor;
            bg = defaultBg;
          };
          warning_diagnostic_visible = {
            fg = warningColor;
            bg = defaultBg;
          };
          warning_diagnostic_selected = {
            fg = warningColor;
            bg = selectedBg;
            sp = warningColor;
            bold = true;
            italic = false;
          };
          error = {
            fg = errorColor;
            bg = defaultBg;
            sp = errorColor;
          };
          error_visible = {
            fg = errorColor;
            bg = defaultBg;
          };
          error_selected = {
            fg = errorColor;
            bg = selectedBg;
            sp = errorColor;
            bold = true;
            italic = false;
          };
          error_diagnostic = {
            fg = errorColor;
            bg = defaultBg;
            sp = errorColor;
          };
          error_diagnostic_visible = {
            fg = errorColor;
            bg = defaultBg;
          };
          error_diagnostic_selected = {
            fg = errorColor;
            bg = selectedBg;
            sp = errorColor;
            bold = true;
            italic = false;
          };
          modified = {
            fg = modifiedColor;
            bg = defaultBg;
          };
          modified_visible = {
            fg = modifiedColor;
            bg = defaultBg;
          };
          modified_selected = {
            fg = modifiedColor;
            bg = selectedBg;
          };
          duplicate_selected = {
            fg = selectedFg;
            bg = selectedBg;
            italic = false;
          };
          duplicate_visible = {
            fg = defaultFg;
            bg = defaultBg;
            italic = false;
          };
          duplicate = {
            fg = defaultFg;
            bg = defaultBg;
            italic = false;
          };
          separator_selected = {
            fg = separatorColor;
            bg = selectedBg;
          };
          separator_visible = {
            fg = separatorColor;
            bg = defaultBg;
          };
          separator = {
            fg = separatorColor;
            bg = defaultBg;
          };
          indicator_visible = {
            fg = defaultFg;
            bg = defaultBg;
          };
          indicator_selected = {
            fg = indicatorColor;
            bg = selectedBg;
          };
          pick_selected = {
            fg = pickColor;
            bg = selectedBg;
            bold = true;
            italic = false;
          };
          pick_visible = {
            fg = pickColor;
            bg = defaultBg;
            bold = true;
            italic = false;
          };
          pick = {
            fg = pickColor;
            bg = defaultBg;
            bold = true;
            italic = false;
          };
          offset_separator = {
            fg = separatorColor;
            bg = offsetColor;
          };
          trunc_marker = {
            fg = defaultFg;
            bg = defaultBg;
          };
        };

        options = rec {
          style_preset = "no_italic";
          separator_style = ["" ""];
          numbers = "none";
          indicator.style = "none";
          color_icons = true;
          show_close_icon = false;
          show_buffer_close_icons = false;
          enforce_regular_tabs = false;
          middle_mouse_command = close_command;

          close_command = lib.mkLuaInline ''
            function(bufnum)
              MiniBufremove.delete(bufnum, false)
            end
          '';

          offsets = [
            {
              filetype = "NvimTree";
              highlight = "BufferlineFileTreeOffset";
              separator = true;
              text = "";
            }
          ];
        };
      };
    };

    highlight = {
      BufferlineFileTreeOffset.bg = darken colors.base00 0.1;
    };
  };
}
