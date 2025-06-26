{
  lib,
  pkgs,
  ...
}: {
  options.custom.common.vars.cursor = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "Simp1e";
    };
    package = lib.mkPackageOption pkgs "simp1e-cursors" {};
    size = lib.mkOption {
      type = lib.types.int;
      default = 32;
    };
  };
}
