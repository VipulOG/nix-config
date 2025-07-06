{
  config.vim.lsp = {
    enable = true;
    formatOnSave = true;
    inlayHints.enable = true;
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
    lspSignature.enable = true;
    lspkind.enable = true;
    lspconfig.enable = true;
  };
}
