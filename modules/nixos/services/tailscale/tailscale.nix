{
  config,
  self,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.services.tailscale;
  useExitNode = cfg.exitNode.wanInterface != "";
in {
  options.custom.services.tailscale = {
    enable = self.lib.mkCustomEnableOption "tailscale";
    enableSSH = lib.mkEnableOption "Tailscale SSH";

    exitNode = {
      wanInterface = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "If this host should be an exit node, specify the WAN interface.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;

      extraUpFlags = lib.lists.optionals cfg.enableSSH ["--ssh"];
      extraSetFlags = lib.lists.optionals useExitNode ["--advertise-exit-node"];

      useRoutingFeatures =
        if useExitNode
        then "both"
        else "client";
    };

    systemd.services.tailscaled = {
      after = ["network.target"];
      wantedBy = ["default.target"];
    };

    environment.systemPackages = lib.lists.optionals useExitNode [
      pkgs.ethtool
    ];

    systemd.services.tailscale-transport-layer-offloads = lib.mkIf useExitNode {
      # See https://tailscale.com/kb/1320/performance-best-practices#ethtool-configuration.
      description = "Tailscale: better performance for exit nodes";
      after = ["network.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          ${lib.getExe pkgs.ethtool} \
            -K ${cfg.exitNode.wanInterface} \
            rx-udp-gro-forwarding on \
            rx-gro-list off
        '';
      };
    };
  };
}
