{
  den.aspects.zsh = {
    nixos = {
      environment.pathsToLink = ["/share/zsh"];
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
