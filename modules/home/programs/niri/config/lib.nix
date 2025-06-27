{
  lib,
  config,
  ...
}: rec {
  spawnIfEnabled = spawnCommand: {
    programs ? [],
    services ? [],
    command,
  }: let
    isEnabled = deps: name: deps.${name}.enable or false;
    disabledPrograms = builtins.filter (name: !(isEnabled config.custom.programs name)) programs;
    disabledServices = builtins.filter (name: !(isEnabled config.custom.services name)) services;
    disabledDeps = disabledPrograms ++ disabledServices;

    disabledDepsError = let
      programInstructions = map (name: "  config.custom.programs.${name}.enable = true;") disabledPrograms;
      serviceInstructions = map (name: "  config.custom.services.${name}.enable = true;") disabledServices;
      allInstructions = programInstructions ++ serviceInstructions;
    in ''
      niri configuration: some required programs or services are disabled.
      Disabled required dependencies: ${lib.concatStringsSep ", " disabledDeps}
      To enable them, add this to your configuration:
      ```
      ${lib.concatLines allInstructions}
      ```
    '';

    collectPackages = names: deps: (
      builtins.listToAttrs (
        map (name: {
          inherit name;
          value = deps.${name}.package;
        })
        names
      )
    );

    depPackages = collectPackages programs config.custom.programs // collectPackages services config.custom.services;
    commandList = command depPackages;
    quotedCommand = lib.concatStringsSep " " (map (item: "\"${item}\"") commandList);
  in
    if disabledDeps != []
    then throw disabledDepsError
    else "${spawnCommand} ${quotedCommand}";

  spawn = spawnIfEnabled "spawn";
  spawn-at-startup = spawnIfEnabled "spawn-at-startup";
}
