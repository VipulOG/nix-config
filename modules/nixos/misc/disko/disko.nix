{
  inputs,
  config,
  self,
  lib,
  ...
}: let
  layoutsDir = ./layouts;
  isNixFile = name: builtins.match ".*\\.nix$" name != null;

  layouts = lib.pipe layoutsDir [
    builtins.readDir

    (lib.filterAttrs (
      name: type:
        type != "directory" && isNixFile name
    ))

    (builtins.mapAttrs (name: _: {
      name = builtins.replaceStrings [".nix"] [""] name;
      value = import (layoutsDir + "/${name}");
    }))

    builtins.attrValues
    builtins.listToAttrs
  ];

  resolveLayout = layout: params: (
    if lib.isFunction layout
    then layout params
    else layout
  );

  cfg = config.custom.misc.disko;
in {
  imports = [inputs.disko.nixosModules.disko];

  options.custom.misc.disko = {
    enable = self.lib.mkCustomEnableOption "disko";

    layout = lib.mkOption {
      description = "Disk layout configuration.";
      type = lib.types.oneOf [
        (lib.types.functionTo (lib.types.attrsOf lib.types.anything))
        (lib.types.attrsOf lib.types.anything)
      ];
      default = layouts.single-disk-ext4;
    };

    params = lib.mkOption {
      description = "Parameters to pass to the selected layout.";
      type = lib.types.attrs;
      default = {};
    };

    layouts = lib.mkOption {
      description = "Set of pre-configured disk layouts.";
      type = lib.types.attrs;
      readOnly = true;
      default = layouts;
    };
  };

  config = lib.mkIf cfg.enable {
    disko.devices = resolveLayout cfg.layout cfg.params;
  };
}
