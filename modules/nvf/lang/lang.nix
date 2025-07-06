{
  config.vim.languages = {
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;
    nix.enable = true;
    lua.enable = true;
    rust = {
      enable = true;
      crates.enable = true;
    };
    python.enable = true;
    markdown.enable = true;
    html.enable = true;
    css.enable = true;
    ts = {
      enable = true;
      extensions.ts-error-translator.enable = true;
    };
  };
}
