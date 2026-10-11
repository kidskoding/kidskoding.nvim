(vim.pack.add [{:src "https://codeberg.org/evergarden/nvim" :name :evergarden}
               "https://github.com/folke/tokyonight.nvim"])

(local evergarden (require :evergarden))
(local tokyonight (require :tokyonight))

(evergarden.setup {:theme {:variant :fall :accent :green}
                   :style {:types []
                           :keyword []
                           :comment []
                           :search [:reverse]
                           :incsearch [:reverse]}
                   :overrides {;; treesitter overrides
                               "@punctuation.bracket" {:link :Normal}
                               "@punctuation.delimiter" {:link :Normal}
                               ;; snacks overrides
                               :SnacksPickerDelim {:link :SnacksPickerRow}
                               :SnacksPickerCol {:link :SnacksPickerRow}
                               ;; trouble overrides
                               :TroubleNormal {:link :Normal}
                               :TroubleNormalNC {:link :Normal}
                               ;; git overrides
                               :Added {:fg "#CBE3B3"}
                               :Removed {:fg "#F57F82"}
                               :Changed {:fg "#F5D098"}
                               :GitSignsChange {:fg "#F5D098"}
                               :GitSignsUntracked {:fg "#B3E3CA"}}})

(tokyonight.setup {:style :moon
                   :styles {:comments {:italic false}
                            :keywords {:italic false}}})

(vim.cmd.colorscheme :tokyonight)
