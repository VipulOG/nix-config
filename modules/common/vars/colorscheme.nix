{
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.custom.common.vars.colorScheme = let
    base16Lib = pkgs.callPackage inputs.base16.lib {};
    schemeYaml = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
  in {
    scheme = lib.mkOption {
      type = with lib.types; attrsOf anything;
      default = base16Lib.mkSchemeAttrs schemeYaml;
    };

    yaml = lib.mkOption {
      type = lib.types.path;
      default = schemeYaml;
    };
  };
}
