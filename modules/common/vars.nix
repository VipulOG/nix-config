{lib, ...}: {
  options.custom.vars = {
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "UTC";
      description = "System timezone";
    };
  };

  config = {
    custom.vars.timeZone = "Asia/Kolkata";
  };
}
