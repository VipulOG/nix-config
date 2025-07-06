{
  config.vim.lsp = {
    enable = true;
    formatOnSave = true;

    inlayHints.enable = true;
    lspSignature.enable = false;
    lspkind.enable = true;
    lspconfig.enable = true;

    lightbulb = {
      enable = true;
      setupOpts = {
        sign = {
          enabled = true;
          text = "";
          lens_text = "";
        };
      };
    };
  };
}
