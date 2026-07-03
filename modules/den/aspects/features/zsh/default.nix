{den, ...}: {
  den.aspects.zsh = {
    host,
    user,
  }: let
    isEphemeralHost = host.hasAspect den.aspects.ephemeral-host;
  in {
    nixos = {lib, ...}: {
      config = lib.mkMerge [
        {environment.pathsToLink = ["/share/zsh"];}

        (lib.mkIf isEphemeralHost {
          preservation.preserve = {
            users = lib.mkIf (user != null) {
              ${user.name}.files = [
                {
                  file = ".zsh_history";
                  mode = "0700";
                }
              ];
            };
          };
        })
      ];
    };

    homeManager = {
      lib,
      pkgs,
      ...
    }: {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        fastSyntaxHighlighting.enable = true;

        plugins = [
          {
            name = "welcome";
            src = pkgs.writeTextDir "welcome.plugin.zsh" ''
              [[ -o interactive ]] || return
              ${lib.getExe pkgs.fastfetch} -l "none"
            '';
          }
        ];
      };
    };
  };
}
