return {
  {
    "sudo-tee/opencode.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          enabled = false,
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
        ft = { "markdown", "opencode_output" },
      },
      "saghen/blink.cmp",
      "folke/snacks.nvim",
    },
    config = function()
      require("opencode").setup({
        default_mode = "plan",
        ui = {
          window_width = 0.42,
          output = {
            rendering = {
              event_throttle_ms = 150, -- Default: 40ms. Triple it.
              markdown_debounce_ms = 1000, -- Default: 250ms. Render markdown less often.
            },
            tools = {
              show_output = false,
              show_reasoning_output = false,
            },
          },
        },
        keymap = {
          editor = {
            ["<leader>om"] = { "mcp", desc = "MCP menu" },
          },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("opencode_filetype", { clear = true }),
        pattern = "opencode",
        callback = function()
          vim.opt_local.textwidth = 90
          vim.opt_local.formatoptions:append("t")
        end,
      })
    end,
  },
}
