{lib, ...}: {
  options.custom.common.constants = {
    timeZone = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      default = "Asia/Kolkata";
      description = "System timezone";
    };
  };
}
