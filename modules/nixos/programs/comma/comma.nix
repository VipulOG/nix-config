{
  config,
  self,
  lib,
  inputs,
  ...
}: let
  cfg = config.custom.programs.comma;
in {
  imports = [inputs.nix-index-database.nixosModules.nix-index];

  options.custom.programs.comma = {
    enable = self.lib.mkCustomEnableOption "comma";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-index-database.comma.enable = true;
  };
}
