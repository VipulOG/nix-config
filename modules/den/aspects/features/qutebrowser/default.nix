{den, ...}: {
  den.aspects.qutebrowser = {
    host,
    user,
  }: let
    isEphemeralHost = host.hasAspect den.aspects.ephemeral-host;
  in {
    nixos = {lib, ...}: {
      config = lib.mkMerge [
        (lib.mkIf isEphemeralHost {
          preservation.preserve = {
            users = lib.mkIf (user != null) {
              ${user.name}.directories = [
                {
                  directory = ".local/share/qutebrowser";
                  mode = "0700";
                }
              ];
            };
          };
        })
      ];
    };

    homeManager = {
      programs.qutebrowser = {
        enable = true;
      };
    };
  };
}
