{
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.programs.neovim;
  codecompanionAdaptersLua = builtins.readFile ./codecompanion/adapters.lua;
in {
  imports = [inputs.nvf.homeManagerModules.default];

  options.internal.programs.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };

    programs.nvf = {
      enable = true;

      settings.vim = {
        vimAlias = true;
        viAlias = true;
        withNodeJs = true;

        options = {
          tabstop = 2;
          shiftwidth = 2;
          scrolloff = 5;
          wrap = false;
        };

        keymaps = [
          {
            key = "<leader>bd";
            mode = ["n"];
            action = "<Cmd>lua MiniBufremove.delete()<CR>";
            silent = true;
            desc = "Delete buffer";
          }
          {
            key = "<leader>bw";
            mode = ["n"];
            action = "<Cmd>lua MiniBufremove.wipeout()<CR>";
            silent = true;
            desc = "Wipeout buffer";
          }
        ];

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lightbulb.enable = true;
          lspSignature.enable = true;
          lspkind.enable = true;
          lspconfig.enable = true;
        };

        languages = {
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

        diagnostics = {
          enable = true;
          config = {
            virtual_lines.enable = true;
            underline = true;
          };
        };

        spellcheck = {
          enable = true;
          languages = ["en"];
          programmingWordlist.enable = true;
        };

        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers = {
            wl-copy.enable = true;
            xsel.enable = true;
          };
        };

        telescope = {
          enable = true;
        };

        treesitter = {
          enable = true;
          autotagHtml = true;
          fold = true;
        };

        autocomplete = {
          nvim-cmp.enable = true;
        };

        utility = {
          outline.aerial-nvim = {
            enable = true;
            mappings.toggle = "<leader>a";
          };
        };

        statusline = {
          lualine = {
            enable = true;
            activeSection = {
              a = [
                ''
                  {
                    "mode",
                    icons_enabled = true,
                    separator = {left = "", right = ""},
                  }
                ''
              ];
              b = [
                ''
                  {
                    "filename",
                    symbols = {modified = ' ', readonly = ' '},
                    separator = {right = ""}
                  }
                ''
              ];
              c = [
                ''
                  {
                    "diff",
                    colored = false,
                    symbols = {added = '+', modified = '~', removed = '-'},
                    separator = {right = ""}
                  }
                ''
              ];
              x = [
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
                    icon = ' ',
                    separator = {left = ""},
                  }
                ''
                ''
                  {
                    "diagnostics",
                    sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'},
                    symbols = {error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 '},
                    colored = true,
                    update_in_insert = false,
                    always_visible = false,
                    diagnostics_color = {
                      color_error = { fg = 'red' },
                      color_warn = { fg = 'yellow' },
                      color_info = { fg = 'cyan' },
                    },
                  }
                ''
              ];
              y = [
                ''
                  {
                    'searchcount',
                    maxcount = 999,
                    timeout = 120,
                    separator = {left = ""}
                  }
                ''
                ''
                  {
                    "branch",
                    icon = ' •',
                    separator = {left = ""}
                  }
                ''
              ];
              z = [
                ''
                  {
                    "progress",
                    separator = {left = ""}
                  }
                ''
                ''
                  {"location"}
                ''
              ];
            };
          };
        };

        tabline = {
          nvimBufferline = {
            enable = true;
            setupOpts = {
              options.numbers = "none";
            };
          };
        };

        visuals = {
          indent-blankline = {
            enable = true;
            setupOpts = {
              exclude.filetypes = ["log" "txt" "md" "dashboard" "help"];
            };
          };
          rainbow-delimiters.enable = true;
          nvim-web-devicons.enable = true;
          cinnamon-nvim = {
            enable = true;
            setupOpts = {
              keymaps.basic = true;
            };
          };
          cellular-automaton.enable = true;
        };

        ui = {
          borders = {
            enable = true;
            globalStyle = "single";
          };
          noice.enable = true;
          smartcolumn = {
            enable = true;
            setupOpts = {
              disabled_filetypes = ["dashboard"];
            };
          };
        };

        notes = {
          todo-comments.enable = true;
        };

        binds = {
          hardtime-nvim.enable = true;
          whichKey.enable = true;
        };

        projects = {
          project-nvim.enable = true;
        };

        dashboard = {
          dashboard-nvim = {
            enable = true;
            setupOpts = {
              config = {
                week_header.enable = true;
                packages.enable = false;
                shortcut = mkForce {};
                footer = mkForce {};
              };
            };
          };
        };

        mini = {
          ai.enable = true;
          basics = {
            enable = true;
            setupOpts = {
              mappings = {
                windows = true;
                move_with_alt = true;
              };
            };
          };
          bracketed.enable = true;
          comment.enable = true;
          cursorword.enable = true;
          jump.enable = true;
          jump2d.enable = true;
          move.enable = true;
          notify = {
            enable = true;
            setupOpts = {
              lsp_progress.enable = false;
              duration_last = 3000;
            };
          };
          operators.enable = true;
          pairs.enable = true;
          splitjoin.enable = true;
          surround.enable = true;
          trailspace.enable = true;
        };

        assistant.codecompanion-nvim = {
          enable = true;
          setupOpts = {
            adapters = lib.generators.mkLuaInline codecompanionAdaptersLua;
            strategies = {
              chat.adapter = "gemini";
              inline.adapter = "gemini";
              cmd.adapter = "gemini";
            };
            opts.send_code = true;
            display.chat.auto_scroll = true;
          };
        };
      };
    };
  };
}
