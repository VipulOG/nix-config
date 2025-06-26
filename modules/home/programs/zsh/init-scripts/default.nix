{lib, ...} @ args:
lib.concatLines (map (
    f: let
      imported = import f;
    in
      if builtins.isFunction imported
      then imported args
      else imported
  ) [
    ./prompt.nix
  ])
