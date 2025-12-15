-- stylua: ignore
if false then return {} end

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        kdl = { "kdlfmt" },
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        zsh = { "beautysh" },
        just = { "just" },
        c = { "clang_format" },
        nu = { "topiary_nu", "nufmt" },
        sql = { "sleek" },
        -- markdown
        -- markdown = { "markdownlint-cli2", "markdown-toc" },
        -- ["markdown.mdx"] = { "markdownlint-cli2", "markdown-toc" },
        markdown = { "mdslw" },
        javascript = { "biome", "biome-organize-imports" },
        javascriptreact = { "biome", "biome-organize-imports" },
        typescript = { "biome", "biome-organize-imports" },
        typescriptreact = { "biome", "biome-organize-imports" },
        go = { "goimports", "gofmt" },
        rst = { "rstfmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
      },
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      formatters = {
        injected = { options = { ignore_errors = true } },

        topiary_nu = {
          command = "topiary",
          args = { "format", "--language", "nu" },
        },
        -- markdown
        mdslw = { prepend_args = { "--stdin-filepath", "$FILENAME" } },
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
        ["clang_format"] = {
          prepend_args = { "--style={IndentWidth: 4}", "--fallback-style=LLVM" },
        },
      },
    },
  },
}
