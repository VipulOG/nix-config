{
  den,
  inputs,
  ...
}: {
  den.aspects.mcp = let
    inherit (den.lib) policy;

    hasSops = {user ? null, ...}:
      user != null && user.hasAspect den.aspects.sops-nix;
  in {
    includes = [
      (policy.when hasSops (policy.include den.aspects.mcp.secrets))
    ];

    homeManager = {
      pkgs,
      config,
      ...
    }: {
      home.packages = [pkgs.nodejs_26];

      programs.mcp = {
        enable = true;

        servers = {
          deepwiki = {
            command = "npx";
            args = ["-y" "mcp-remote" "https://mcp.deepwiki.com/mcp"];
          };

          github = {
            command = "npx";
            args = ["-y" "mcp-remote" "https://api.githubcopilot.com/mcp"];
          };
        };
      };
    };

    secrets = {
      homeManager = {config, ...}: {
        sops.secrets.github-mcp-pat = {
          sopsFile = "${inputs.my-secrets}/secrets/sops/shared.yaml";
        };

        programs.mcp.servers = {
          github = {
            env.GITHUB_MCP_PAT.file = config.sops.secrets.github-mcp-pat.path;
            args = ["--header" "Authorization:Bearer \$\{GITHUB_MCP_PAT\}"];
          };
        };
      };
    };
  };
}
