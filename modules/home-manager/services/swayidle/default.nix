{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.services.swayidle;
  defaultSwaylockPkg = config.internal.programs.swaylock.package ? pkgs.swaylock-effects;
in {
  options.internal.services.swayidle = {
    enable = mkEnableOption "Enable swayidle integration.";
    package = lib.mkPackageOption pkgs "swayidle" {};

    swaylockPackage = mkOption {
      type = types.package;
      default = defaultSwaylockPkg;
      description = "The package to use for swalock.";
    };

    lockTimeout = mkOption {
      type = types.int;
      default = 60;
      description = "Time (in seconds) of inactivity before locking the monitors.";
    };

    lockCommand = mkOption {
      type = types.str;
      default = "${lib.getExe' swaylockPackage "swaylock"} -fF --grace 10 --fade-in 4";
      description = "Command to execute to lock the monitors.";
    };

    preSleepLockCommand = mkOption {
      type = types.str;
      default = "${lib.getExe' swaylockPackage "swaylock"} -fF";
      description = "Command to run just before the system goes to sleep (e.g., to lock the monitors).";
    };

    monitorsOffTimeout = mkOption {
      type = types.int;
      default = 65;
      description = "Time (in seconds) of inactivity before turning off the monitors.";
    };

    monitorsOffCommand = mkOption {
      type = types.str;
      description = "Command to execute to turn off the monitors.";
    };

    monitorsOnCommand = mkOption {
      type = types.str;
      description = "Command to execute to turn the monitors back on when resuming.";
    };

    suspendTimeout = mkOption {
      type = types.int;
      default = 80;
      description = "Time (in seconds) of inactivity before suspending the system.";
    };

    extraConfig = mkOption {
      type = types.attrsOf types.anything;
      description = "Additional swayidle configuration options.";
      default = {};
    };
  };

  config = mkIf cfg.enable {
    services.swayidle =
      {
        enable = true;
        inherit (cfg) package;

        timeouts = [
          {
            timeout = cfg.lockTimeout;
            command = cfg.lockCommand;
          }
          {
            timeout = cfg.monitorsOffTimeout;
            command = cfg.monitorsOffCommand;
            resumeCommand = cfg.monitorsOnCommand;
          }
          {
            timeout = cfg.suspendTimeout;
            command = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
          }
        ];

        events = [
          {
            event = "before-sleep";
            command = cfg.preSleepLockCommand;
          }
        ];
      }
      // cfg.extraConfig;
  };
}
