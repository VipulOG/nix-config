{lib, ...}: {
  options.custom.common.vars.time = {
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Asia/Kolkata";
    };
  };
}
