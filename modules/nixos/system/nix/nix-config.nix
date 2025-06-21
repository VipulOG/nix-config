{
  inputs,
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.system.nix;
in {
  options.custom.system.nix = {
    enable = self.lib.mkCustomEnableOption "nix";
  };

  config = lib.mkIf cfg.enable {
    nix = {
      settings = {
        # See https://jackson.dev/post/nix-reasonable-defaults/
        connect-timeout = 5;
        log-lines = 25;
        min-free = 30 * 1024 * 1024 * 1024; # 30GB
        max-free = 50 * 1024 * 1024 * 1024; # 50GB
        auto-optimise-store = true;
        warn-dirty = false;
        keep-outputs = true;
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["root" "@wheel"];
      };

      optimise = {
        automatic = true;
        dates = ["7d"];
      };

      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

      # This will add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    };
  };
}
