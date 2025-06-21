{
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.services.networking.firewall;
in {
  options.custom.services.networking.firewall = {
    enable = self.lib.mkCustomEnableOption "firewall";

    globalTCP = lib.mkOption {
      type = lib.types.listOf lib.types.port;
      default = [];
      description = "List of TCP ports to allow globally.";
    };

    globalUDP = lib.mkOption {
      type = lib.types.listOf lib.types.port;
      default = [];
      description = "List of UDP ports to allow globally.";
    };

    interfaces = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          tcp = lib.mkOption {
            type = lib.types.listOf lib.types.port;
            default = [];
            description = "List of TCP ports to allow on this interface.";
          };
          udp = lib.mkOption {
            type = lib.types.listOf lib.types.port;
            default = [];
            description = "List of UDP ports to allow on this interface.";
          };
        };
      });
      default = {};
      description = "Attribute set of interface-specific firewall rules.";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = cfg.globalTCP;
      allowedUDPPorts = cfg.globalUDP;

      interfaces = lib.pipe cfg.interfaces [
        (lib.mapAttrs (_name: ifaceCfg: {
          allowedTCPPorts = ifaceCfg.tcp;
          allowedUDPPorts = ifaceCfg.udp;
        }))
      ];
    };
  };
}
