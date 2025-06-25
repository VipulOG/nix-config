{
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.custom.common.constants = {
    colorScheme = lib.mkOption {
      type = with lib.types; attrsOf anything;
      readOnly = true;
      default = let
        base16Lib = pkgs.callPackage inputs.base16.lib {};
        scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
      in
        base16Lib.mkSchemeAttrs scheme;
    };
  };
}
