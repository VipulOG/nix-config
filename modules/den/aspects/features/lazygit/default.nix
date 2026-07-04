{
  den.aspects.lazygit = {
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

    preservation = {user}: {
      preserve.users.${user.name}.directories = [
        {
          directory = ".local/state/lazygit";
          mode = "0700";
        }
      ];
    };
  };
}
