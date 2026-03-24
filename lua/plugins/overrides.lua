local function toggle_all(picker)
  local new_state = not picker.opts.hidden
  picker.opts.hidden = new_state
  picker.opts.ignored = new_state
  picker:find()
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lazyvim_lsp_signature", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.signatureHelpProvider then
            client.server_capabilities.signatureHelpProvider.triggerCharacters = {}
          end
        end,
      })
    end,
    keys = {
      {
        "<C-k>",
        function()
          vim.lsp.buf.signature_help()
        end,
        mode = "i",
        desc = "Signature Help",
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
⠀⣠⠾⡟⠓⠿⠇⠀⠀⣮⠍⢹⣿⣷⠀⠀⠀⠀⣤⡤⢀⠀⠀
⣴⣏⣀⡇⢀⠀⣀⡀⠸⠆⢰⣹⢻⠏⠀⠀⠀⠈⠛⠛⣿⣧⠀
⠻⢯⣵⣷⠦⣬⣢⠀⠁⠒⢻⣧⠧⠦⠤⠀⡠⣀⠤⢴⣿⠃⠃
⠀⠀⠉⠙⠛⢻⡛⣧⣀⠀⢀⣿⠇⠀⠠⣶⣽⣗⠓⠺⣟⢶⡆
⠀⠀⠀⠀⠀⠘⣿⣿⣿⡿⢑⣌⠴⠚⢋⠉⡯⠉⠛⠀⠉⠀⠀
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]],
        },
      },
      picker = {
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["H"] = "toggle_all",
                },
              },
            },
            actions = {
              toggle_all = toggle_all,
            },
          },
          files = {
            win = {
              list = {
                keys = {
                  ["H"] = "toggle_all",
                },
              },
            },
            actions = {
              toggle_all = toggle_all,
            },
          },
          grep = {
            win = {
              list = {
                keys = {
                  ["H"] = "toggle_all",
                },
              },
            },
            actions = {
              toggle_all = toggle_all,
            },
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        trigger = {
          show_on_keyword = false, -- no popup while typing words
          show_on_trigger_character = true, -- popup on ".", "/", etc.
          show_on_insert_on_trigger_character = true, -- popup when entering insert after "."
          show_on_accept_on_trigger_character = true, -- chain completions after accepting
        },
        menu = {
          auto_show = true,
        },
      },
      keymap = {
        ["<A-Space>"] = { "show", "hide" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        style_preset = require("bufferline").style_preset.minimal,
      },
    },
  },
}
