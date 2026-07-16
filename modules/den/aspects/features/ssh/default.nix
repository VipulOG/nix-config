{
  den.aspects.ssh = {
    homeManager = {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        settings."*" = {
          AddKeysToAgent = "yes";
          ForwardAgent = "yes";
        };
      };
    };
  };
}
