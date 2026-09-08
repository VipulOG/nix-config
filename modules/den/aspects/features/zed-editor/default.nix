{
  den.aspects.zed-editor = {user}: {
    homeManager = {pkgs, ...}: {
      programs.zed-editor = {
        enable = true;
        enableMcpIntegration = true;

        extraPackages = [
          pkgs.nixd
          pkgs.nil
          pkgs.alejandra
        ];

        extensions = [
          "nix"
          "toml"
          "html"
          "justfile"
          "dockerfile"
          "xy-zed"
          "colored-zed-icons-theme"
        ];

        userSettings = {
          telemetry = {
            diagnostics = false;
            metrics = false;
            anthropic_retention = false;
          };

          vim_mode = true;

          icon_theme = {
            mode = "dark";
            light = "Colored Zed Icons Theme Light";
            dark = "Colored Zed Icons Theme Dark";
          };

          theme = {
            mode = "dark";
            light = "XY-Zed";
            dark = "XY-Zed";
          };

          format_on_save = "on";

          languages = {
            Nix = {
              formatter = {
                external = {
                  command = "alejandra";
                  arguments = ["--quiet" "--"];
                };
              };
            };
          };

          agent = {
            play_sound_when_agent_done = "always";
          };

          agent_servers = {
            claude-acp = {
              type = "registry";
            };

            github-copilot-cli = {
              type = "registry";
            };

            codex-acp = {
              type = "registry";
            };

            antigravity-acp = {
              type = "registry";
            };
          };
        };
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".config/zed"
        ".local/share/zed"
        ".cache/zed"
      ];
    };
  };
}
