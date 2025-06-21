{lib, ...}: {
  mkCustomEnableOption = name: lib.mkEnableOption "custom ${name} module";
}
