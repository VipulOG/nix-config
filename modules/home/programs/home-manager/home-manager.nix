{
  config,
  lib,
  self,
  ...
}: let
  cfg = config.custom.programs.home-manager;
in {
  options.custom.programs.home-manager = {
    enable = self.lib.mkCustomEnableOption "home-manager";
  };

  config = lib.mkIf cfg.enable {
    news.display = "silent";
    programs.home-manager = {
      enable = true;
    };
  };
}
