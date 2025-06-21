{
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.programs.zsh;
in {
  options.custom.programs.zsh = {
    enable = self.lib.mkCustomEnableOption "zsh";

    enableCompletion = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable zsh completion.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      inherit (cfg) enableCompletion;
    };
  };
}
