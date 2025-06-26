{
  config,
  pkgs,
  lib,
  self,
  ...
}: let
  cfg = config.custom.services.swayidle;

  defaultSwaylockPkg =
    if config.custom.programs.swaylock.enable
    then config.custom.programs.swaylock.package
    else pkgs.swaylock-effects;
in {
  options.custom.services.swayidle = {
    enable = self.lib.mkCustomEnableOption "Enable swayidle integration.";
    package = lib.mkPackageOption pkgs "swayidle" {};

    swaylockPackage = lib.mkOption {
      type = lib.types.package;
      default = defaultSwaylockPkg;
      description = "The package to use for swalock.";
    };

    lockTimeout = lib.mkOption {
      type = lib.types.int;
      default = 60;
      description = "Time (in seconds) of inactivity before locking the monitors.";
    };

    lockCommand = lib.mkOption {
      type = lib.types.str;
      default = "${lib.getExe' cfg.swaylockPackage "swaylock"} -fF --grace 10 --fade-in 4";
      description = "Command to execute to lock the monitors.";
    };

    preSleepLockCommand = lib.mkOption {
      type = lib.types.str;
      default = "${lib.getExe' cfg.swaylockPackage "swaylock"} -fF";
      description = "Command to run just before the system goes to sleep (e.g., to lock the monitors).";
    };

    monitorsOffTimeout = lib.mkOption {
      type = lib.types.int;
      default = 65;
      description = "Time (in seconds) of inactivity before turning off the monitors.";
    };

    monitorsOffCommand = lib.mkOption {
      type = lib.types.str;
      description = "Command to execute to turn off the monitors.";
    };

    monitorsOnCommand = lib.mkOption {
      type = lib.types.str;
      description = "Command to execute to turn the monitors back on when resuming.";
    };

    suspendTimeout = lib.mkOption {
      type = lib.types.int;
      default = 80;
      description = "Time (in seconds) of inactivity before suspending the system.";
    };

    extraConfig = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      description = "Additional swayidle configuration options.";
      default = {};
    };
  };

  config = lib.mkIf cfg.enable (
    {
      services.swayidle = {
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
      };
    }
    # // cfg.extraConfig
  );
}
