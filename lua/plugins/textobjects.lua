-- ============================================================================
-- Text Objects (额外的文本对象)
-- ============================================================================

return {
  "kana/vim-textobj-entire",
  dependencies = { "kana/vim-textobj-user" },
  keys = {
    { "ae", mode = { "o", "x" }, desc = "Entire buffer" },
    { "ie", mode = { "o", "x" }, desc = "Entire buffer (no leading/trailing empty lines)" },
  },
}
