{
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.custom.common.constants = let
    schemeYaml = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    base16Lib = pkgs.callPackage inputs.base16.lib {};
  in {
    colorScheme = lib.mkOption {
      type = with lib.types; attrsOf anything;
      readOnly = true;
      default = base16Lib.mkSchemeAttrs schemeYaml;
    };

    colorSchemeYaml = lib.mkOption {
      type = lib.types.path;
      readOnly = true;
      default = schemeYaml;
    };
  };
}
