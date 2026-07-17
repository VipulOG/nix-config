{inputs, ...}: {
  den.aspects.mcp = {
    homeManager = {
      pkgs,
      config,
      ...
    }: {
      home.packages = [pkgs.nodejs_26];

      sops.secrets.github-mcp-pat = {
        sopsFile = "${inputs.my-secrets}/secrets/sops/shared.yaml";
      };

      programs.mcp = {
        enable = true;

        servers = {
          deepwiki = {
            command = "npx";

            args = [
              "-y"
              "mcp-remote"
              "https://mcp.deepwiki.com/mcp"
            ];
          };

          github = {
            command = "npx";

            env = {
              GITHUB_MCP_PAT.file = config.sops.secrets.github-mcp-pat.path;
            };

            args = [
              "-y"
              "mcp-remote"
              "https://api.githubcopilot.com/mcp"
              "--header"
              "Authorization:Bearer \$\{GITHUB_MCP_PAT\}"
            ];
          };
        };
      };
    };
  };
}
