{config, ...}: let
  stylixColors = config.lib.stylix.colors.withHashtag or null;

  baseColors = {
    base00 = "";
    base0D = "";
  };

  colors =
    if stylixColors != null
    then stylixColors
    else baseColors;
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
