{lib, ...} @ args:
lib.concatLines (map (
    f: let
      imported = import f;
    in
      if builtins.isFunction imported
      then imported args
      else imported
  ) [
    ./input.nix
    ./layout.nix
    ./misc.nix
    ./workspaces.nix
    ./startup.nix
    ./window-rules.nix
    ./layer-rules.nix
    ./bindings.nix
  ])
