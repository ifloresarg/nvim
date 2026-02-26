return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
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
              toggle_all = function(picker)
                local new_state = not picker.opts.hidden
                picker.opts.hidden = new_state
                picker.opts.ignored = new_state
                picker:find()
              end,
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
              toggle_all = function(picker)
                local new_state = not picker.opts.hidden
                picker.opts.hidden = new_state
                picker.opts.ignored = new_state
                picker:find()
              end,
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
              toggle_all = function(picker)
                local new_state = not picker.opts.hidden
                picker.opts.hidden = new_state
                picker.opts.ignored = new_state
                picker:find()
              end,
            },
          },
        },
      },
    },
  },
}
