{config, ...}: let
  colors = config.custom.common.vars.colorScheme.scheme.withHashtag;
in {
  config = {
    vim.statusline = {
      lualine = {
        enable = true;
        theme = "base16";
        activeSection = {
          a = [
            ''
              {
                "mode",
                icons_enabled = false,
                icon = nil,
                separator = nil,
                draw_empty = true,
                color = {
                  gui = 'bold',
                },
                fmt = function(str)
                  return " "
                end,
                padding = {
                  left = 0,
                  right = 0,
                },
              }
            ''
          ];
          b = [
            ''
              {
                "filename",
                icons_enabled = true,
                icon = nil,
                symbols = {
                  modified = ' ',
                  readonly = ' ',
                },
                separator = nil,
                draw_empty = false,
                color = {
                  fg = "${colors.base05}",
                  bg = "${colors.base01}",
                },
              }
            ''
          ];
          c = [];
          x = [
            ''
              {
                require("noice").api.statusline.mode.get,
                cond = require("noice").api.statusline.mode.has,
                icons_enabled = false,
                icon = nil,
                separator = nil,
                draw_empty = false,
                color = {
                  fg = "${colors.base0E}",
                  bg = "${colors.base01}",
                },
                padding = {
                  left = 0,
                  right = 1,
                },
              }
            ''
            ''
              {
                function()
                  return [[|]]
                end,
                cond = require("noice").api.statusline.mode.has,
                icons_enabled = false,
                icon = nil,
                separator = nil,
                draw_empty = false,
                color = {
                  fg = "${colors.base03}",
                  bg = "${colors.base01}",
                },
                padding = {
                  left = 0,
                  right = 1,
                },
              }
            ''
            ''
              {
                -- Lsp server name
                function()
                  local buf_ft = vim.bo.filetype
                  local excluded_buf_ft = {
                    toggleterm = true,
                    NvimTree = true,
                    ["neo-tree"] = true,
                    TelescopePrompt = true
                  }

                  if excluded_buf_ft[buf_ft] then
                    return ""
                    end

                  local bufnr = vim.api.nvim_get_current_buf()
                  local clients = vim.lsp.get_clients({ bufnr = bufnr })

                  if vim.tbl_isempty(clients) then
                    return "No Active LSP"
                  end

                  local active_clients = {}
                  for _, client in ipairs(clients) do
                    table.insert(active_clients, client.name)
                  end

                  return table.concat(active_clients, ", ")
                end,
                icons_enabled = true,
                icon = ' ',
                separator = nil,
                draw_empty = false,
                color = {
                  fg = "${colors.base04}",
                  bg = "${colors.base01}",
                },
                padding = {
                  left = 0,
                  right = 1,
                },
              }
            ''
            ''
              {
                function()
                  return [[|]]
                end,
                icons_enabled = false,
                icon = nil,
                separator = nil,
                draw_empty = false,
                color = {
                  fg = "${colors.base03}",
                  bg = "${colors.base01}",
                },
                padding = {
                  left = 0,
                  right = 1,
                },
              }
            ''
          ];
          y = [
            ''
              {
                "branch",
                cond = function()
                  local ok, MiniGit = pcall(require, 'mini.git')
                  if not ok then return false end

                  local data = MiniGit.get_buf_data()
                  local git_branch = data and data.head_name
                  return git_branch ~= nil and git_branch ~= ""
                end,
                icons_enabled = true,
                icon = '',
                separator = nil,
                draw_empty = false,
                color = {
                  fg = "${colors.base04}",
                  bg = "${colors.base01}",
                },
                padding = {
                  left = 0,
                  right = 1,
                },
              }
            ''
            ''
              {
                function()
                  return [[|]]
                end,
                cond = function()
                  local ok, MiniGit = pcall(require, 'mini.git')
                  if not ok then return false end

                  local data = MiniGit.get_buf_data()
                  local git_branch = data and data.head_name
                  return git_branch ~= nil and git_branch ~= ""
                end,
                icons_enabled = false,
                icon = nil,
                separator = nil,
                draw_empty = false,
                color = {
                  fg = "${colors.base03}",
                  bg = "${colors.base01}",
                },
                padding = {
                  left = 0,
                  right = 1,
                },
              }
            ''
          ];
          z = [
            ''
              {
                "progress",
                icons_enabled = false,
                icon = nil,
                separator = nil,
                draw_empty = false,
                color = {
                  fg = "${colors.base04}",
                  bg = "${colors.base01}",
                },
                padding = {
                  left = 0,
                  right = 1,
                },
              }
            ''
            ''
              {
                "location",
                icons_enabled = false,
                icon = nil,
                separator = nil,
                draw_empty = false,
                color = {
                  fg = "${colors.base04}",
                  bg = "${colors.base01}",
                },
                padding = {
                  left = 0,
                  right = 1,
                },
              }
            ''
          ];
        };
      };
    };
  };
}
