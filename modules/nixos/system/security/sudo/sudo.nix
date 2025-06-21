{
  lib,
  config,
  self,
  ...
}: let
  cfg = config.custom.system.security.sudo;
in {
  options.custom.system.security.sudo = {
    enable = self.lib.mkCustomEnableOption "sudo";

    lecture = lib.mkOption {
      type = lib.types.enum [
        "never"
        "always"
        "once"
      ];
      default = "never";
      description = "Controls when the sudo lecture is displayed.";
    };

    pwFeedback = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable password input feedback (shows asterisks while typing).";
    };

    timestampTimeout = lib.mkOption {
      type = lib.types.int;
      default = 60;
      description = "The time (in minutes) before sudo requires the password again.";
    };
  };

  config = lib.mkIf cfg.enable {
    security.sudo.extraConfig = lib.mkMerge [
      # Defaults lecture=never|always|once
      "Defaults lecture=${cfg.lecture}"
      # Shows asterisks when typing password (if enabled)
      (lib.optionalString cfg.pwFeedback "Defaults pwfeedback")
      # Timeout in minutes before password is required again
      "Defaults timestamp_timeout=${toString cfg.timestampTimeout}"
    ];
  };
}
