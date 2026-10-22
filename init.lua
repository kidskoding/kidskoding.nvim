-- On NixOS, Home Manager puts plugins on packpath (NVIM_NIX_PLUGINS=1).
-- Elsewhere, vim.pack installs plugins (including hotpot) at runtime.
if vim.env.NVIM_NIX_PLUGINS == "1" then
  vim.pack.add = function() end
else
  vim.pack.add({
    {
      src = "https://github.com/rktjmp/hotpot.nvim",
      version = vim.version.range("^2.0.0"),
    },
  })
end

require("hotpot")
require("hotpot.api").context(vim.fn.stdpath("config")).sync()
require("config")
