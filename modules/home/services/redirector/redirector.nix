{
  inputs,
  inputs',
  lib,
  config,
  self,
  ...
}: let
  cfg = config.custom.services.redirector;
in {
  imports = [inputs.redirector.homeManagerModules.redirector];

  options.custom.services.redirector = {
    enable = self.lib.mkCustomEnableOption "redirector";
    package = lib.mkPackageOption inputs'.redirector.packages "redirector" {};
  };

  config = lib.mkIf cfg.enable {
    services.redirector = {
      enable = true;
      inherit (cfg) package;
      settings = {
        default_search = "https://duckduckgo.com/?q={}";
        search_suggestions = "https://search.brave.com/api/suggest?q={}";
        bangs = [
          {
            trigger = "hmopt";
            url_template = "https://home-manager-options.extranix.com/?query={{{s}}}";
          }
        ];
      };
    };
  };
}
