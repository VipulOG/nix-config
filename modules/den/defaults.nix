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

    schema = let
      preservationFwd = den.batteries.forward {
        each = lib.singleton true;
        fromClass = _item: "preservation";
        intoClass = _item: "nixos";
        intoPath = _item: ["preservation"];
      };
    in {
      host = {
        includes = [
          den.batteries.hostname
          den.aspects.nix
          den.aspects.home-manager
          den.aspects.nur
          den.aspects.localization

          preservationFwd
        ];
      };

      user = {
        includes = [
          den.batteries.host-aspects
          preservationFwd
        ];

        classes = lib.mkDefault ["homeManager"];
      };
    };
  };
}
