{
  imports = [
    ./ai
    ./autocomplete
    ./binds
    ./clipboard
    ./comments
    ./dashboard
    ./diagnostics
    ./filetree
    ./git
    ./lang
    ./lsp
    ./mini
    ./notes
    ./notify
    ./options
    ./projects
    ./spellcheck
    ./statusline
    ./tabline
    ./telescope
    ./theme
    ./treesitter
    ./ui
    ./utility
    ./visuals
  ];

  config.vim = {
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
  };
}
