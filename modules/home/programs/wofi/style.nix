{config, ...}: let
  colors =
    if builtins.hasAttr "withHashtag" config.lib.stylix.colors
    then config.lib.stylix.colors.withHashtag
    else config.custom.common.constants.colorScheme.withHashtag;
in
  #css
  ''
    #outer-box {
      padding: 20px;
      border: 3px solid ${colors.base0D};
    }

    #input {
      border: 0;
      padding: 8px 12px;
    }

    #scroll {
      margin-top: 20px;
    }

    #img {
      padding-right: 8px;
    }

    #text:selected {
      color: ${colors.base00};
    }

    #entry {
      padding: 6px;
    }

    #entry:nth-child(odd) {
      background-color: ${colors.base00};
    }

    #entry:nth-child(even) {
      background-color: ${colors.base00};
    }

    #entry:selected {
      background-color: ${colors.base0D};
    }

    #input,
    #entry:selected {
      border-radius: 0;
    }
  ''
