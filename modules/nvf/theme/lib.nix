{lib, ...}: {
  color = {
    base16Colors = config: let
      colors = config.custom.common.vars.colorScheme.scheme.withHashtag;
      baseColorPattern = "^base0[0-9a-fA-F]$";
      isBaseColor = name: _: builtins.match baseColorPattern name != null;
    in
      lib.attrsets.filterAttrs isBaseColor colors;

    darken = color: percent: let
      hexToInt = hex: builtins.fromJSON "[0x${hex}]";
      scale = c: builtins.floor (c * (1.0 - percent));

      r = hexToInt (builtins.substring 1 2 color);
      g = hexToInt (builtins.substring 3 2 color);
      b = hexToInt (builtins.substring 5 2 color);

      newR = scale r;
      newG = scale g;
      newB = scale b;

      toHex = c: (
        if c < 16
        then "0${builtins.toHexString c}"
        else builtins.toHexString c
      );
    in
      lib.pipe [newR newG newB] [
        (lib.concatMapStrings toHex)
        (hex: "#${hex}")
      ];
  };
}
