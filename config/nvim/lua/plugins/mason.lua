return {
  "williamboman/mason.nvim",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      "ts_ls",
      "preetier",
      "preetierd",
      "eslint",
      "nil-ls",
    },
  },
}
