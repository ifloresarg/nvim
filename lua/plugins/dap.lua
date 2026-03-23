return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end

      dap.configurations.typescript = dap.configurations.typescript or {}

      if vim.fn.filereadable(vim.fn.getcwd() .. "/nest-cli.json") == 1 then
        local function has_config(name)
          return vim.tbl_contains(
            vim.tbl_map(function(c) return c.name end, dap.configurations.typescript),
            name
          )
        end

        if not has_config("NestJS: Debug") then
          table.insert(dap.configurations.typescript, {
            type = "pwa-node",
            request = "launch",
            name = "NestJS: Debug",
            runtimeExecutable = "pnpm",
            runtimeArgs = { "run", "start:debug" },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**", "**/node_modules/**" },
            resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          })
        end

        if not has_config("NestJS: Attach (port 9229)") then
          table.insert(dap.configurations.typescript, {
            type = "pwa-node",
            request = "attach",
            name = "NestJS: Attach (port 9229)",
            port = 9229,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**", "**/node_modules/**" },
            resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          })
        end
      end
    end,
  },
}
