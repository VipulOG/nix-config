{config, ...}: let
  colors = config.custom.common.vars.colorScheme.scheme.withHashtag;
in {
  config = {
    vim.theme = {
      enable = true;
      name = "base16";
      base16-colors = {
        inherit
          (colors)
          base00
          base01
          base02
          base03
          base04
          base05
          base06
          base07
          base08
          base09
          base0A
          base0B
          base0C
          base0D
          base0E
          base0F
          ;
      };
    };
  };
}
