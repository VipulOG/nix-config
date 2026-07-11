{
  lib,
  den,
  ...
}: {
  den = {
    default = let
      preservationFwd = den.batteries.forward {
        each = lib.singleton true;
        fromClass = _item: "preservation";
        intoClass = _item: "nixos";
        intoPath = _item: ["preservation"];
      };
    in {
      includes = [
        den.batteries.hostname
        den.batteries.inputs'
        den.batteries.self'

        den.aspects.nix
        den.aspects.home-manager
        den.aspects.nur
        den.aspects.localization

        preservationFwd
      ];
    };

    schema.user.classes = lib.mkDefault ["homeManager"];
  };
}
