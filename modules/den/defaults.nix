{
  lib,
  den,
  ...
}: {
  den = {
    default = {
      includes = [
        den.batteries.inputs'
        den.batteries.self'
      ];
    };

    schema = {
      host = {
        includes = [
          den.batteries.hostname
          den.aspects.nix
          den.aspects.home-manager
          den.aspects.nur
          den.aspects.localization
        ];
      };

      user = {
        includes = [
          den.batteries.host-aspects
          den.policies.expose-persist
        ];

        classes = lib.mkDefault ["homeManager"];
      };
    };

    quirks = {
      persist = {
        description = "Preservation config contributed by aspects";
      };
    };

    policies = {
      expose-persist = {user, ...}: let
        inherit (den.lib.policy) pipe;
      in [(pipe.from "persist" [pipe.expose])];
    };
  };
}
