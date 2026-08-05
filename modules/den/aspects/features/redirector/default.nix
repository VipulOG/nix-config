{inputs, ...}: {
  flake-file.inputs = {
    redirector = {
      url = "github:vipulog/redirector-flake";

      inputs = {
        flake-parts.follows = "flake-parts";
        git-hooks-nix.follows = "git-hooks-nix";
        treefmt-nix.follows = "treefmt-nix";
        home-manager.follows = "home-manager";
      };
    };
  };

  den.aspects.redirector = {
    homeManager = {lib, ...}: {
      imports = [inputs.redirector.homeModules.default];

      services.redirector = {
        enable = true;

        settings = {
          port = 3030;
          default_search = "https://duckduckgo.com/?q={}";
          search_suggestions = "https://search.brave.com/api/suggest?q={}";

          bangs = [
            {
              trigger = "hmopt";
              url_template = "https://search.nixos.org/options?query={{{s}}}&source=home_manager&type=options";
            }

            {
              trigger = "noog";
              url_template = "https://noogle.dev/q?term={{{s}}}";
            }
          ];
        };
      };
    };
  };
}
