(vim.pack.add ["https://github.com/folke/tokyonight.nvim"])

(local tokyonight (require :tokyonight))

(tokyonight.setup {:style :moon
                   :styles {:comments {:italic false}
                            :keywords {:italic false}}
                   :on_highlights (fn [highlights _colors]
                                    (set highlights.Added {:fg "#CBE3B3"})
                                    (set highlights.Removed {:fg "#F57F82"})
                                    (set highlights.Changed {:fg "#F5D098"})
                                    (set highlights.GitSignsChange
                                         {:fg "#F5D098"})
                                    (set highlights.GitSignsUntracked
                                         {:fg "#B3E3CA"}))})

(vim.cmd.colorscheme :tokyonight)
