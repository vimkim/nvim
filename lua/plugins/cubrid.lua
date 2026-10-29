return {
  {
    "vimkim/cubrid.nvim",
    dir = "/home/vimkim/gh/cubrid.nvim",
    lazy = false,
    main = "cubrid",
    opts = {
      file_extensions = { ".sql", ".csql" },
      server_path = "/home/vimkim/gh/cubrid-language-tools/.venv/bin/cubrid-language-server",
      parser_worker = "/home/vimkim/gh/cubrid-language-tools/native/parser-worker/build/parser-worker",
      runtime_prefix = "/home/vimkim/.cub/install/develop/debug",
    },
  },
}
