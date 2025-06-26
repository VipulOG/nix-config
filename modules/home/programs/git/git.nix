{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.git;
in {
  options.custom.programs.git = {
    enable = self.lib.mkCustomEnableOption "git";
    package = lib.mkPackageOption pkgs "git" {};

    userName = lib.mkOption {
      type = lib.types.str;
      default = "VipulOG";
      description = "The username to use for Git commits.";
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
      default = "90324465+VipulOG@users.noreply.github.com";
      description = "The email to use for Git commits.";
    };

    extraConfig = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = {};
      description = "Additional Git configuration options.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      inherit (cfg) package userName userEmail;

      extraConfig = lib.mkMerge [
        {
          init.defaultBranch = "main";
          trim.bases = "develop,master,main"; # for git-trim
          push.autoSetupRemote = true;
          pull.rebase = true;

          # Replace https with ssh
          url."ssh://git@github.com/vipulog" = {
            insteadOf = "https://github.com/vipulog";
          };
        }

        cfg.extraConfig # User-provided extraConfig
      ];

      # A syntax-highlighting pager in Rust
      delta = {
        package = pkgs.delta;
        enable = true;
        options = {
          diff-so-fancy = true;
          line-numbers = true;
          true-color = "always";
        };
      };
    };

    home = {
      packages = [pkgs.git-trim];

      sessionVariables = {
        # enable scrolling in git diff
        DELTA_PAGER = "less -R";
      };

      # programs.git will generate the config file: ~/.config/git/config
      # to make git use this config file, ~/.gitconfig should not exist!
      # https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
      activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
        rm -f ${config.home.homeDirectory}/.gitconfig
      '';
    };
  };
}
