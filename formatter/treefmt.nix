{
  perSystem = {
    treefmt = {
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        shellcheck.enable = true;
        shfmt.enable = true;
        prettier.enable = true;
        kdlfmt.enable = true;
      };

      settings.formatter = {
        deadnix = {
          no_lambda_arg = true;
        };
      };
    };
  };
}
