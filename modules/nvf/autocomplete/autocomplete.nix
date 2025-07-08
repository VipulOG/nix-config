{
  config.vim = {
    autocomplete = {
      nvim-cmp = {
        enable = true;
        mappings.next = "<C-n>";
        mappings.previous = "<C-p";
      };
    };
    highlight = {
      CmpItemAbbr = {bg = "NONE";};
      CmpItemAbbrMatch = {bg = "NONE";};
      CmpItemAbbrMatchFuzzy = {bg = "NONE";};
      CmpItemKind = {bg = "NONE";};
      CmpItemMenu = {bg = "NONE";};
    };
  };
}
