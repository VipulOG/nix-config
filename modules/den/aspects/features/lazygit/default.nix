{
  den.aspects.lazygit = {user}: {
    homeManager = {pkgs, ...}: {
      programs.lazygit = {
        enable = true;

        settings = {
          git.pagers = [
            {pager = "${pkgs.delta}/bin/delta --dark --paging=never";}
          ];

          gui = {
            expandFocusedSidePanel = true;
            nerdFontsVersion = "3";
          };
        };
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        {
          directory = ".local/state/lazygit";
          mode = "0700";
        }
      ];
    };
  };
}
