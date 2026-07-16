{
  den.aspects.ssh = {
    homeManager = {
      host,
      user,
      ...
    }: {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        settings."*" = {
          IdentityFile = "~/.ssh/id_${user.name}_${host.name}";
          IdentitiesOnly = "yes";
          AddKeysToAgent = "yes";
          ForwardAgent = "yes";
        };
      };
    };
  };
}
