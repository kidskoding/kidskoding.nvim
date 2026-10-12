(vim.pack.add ["https://github.com/nvim-lualine/lualine.nvim"
               "https://github.com/nvim-tree/nvim-web-devicons"
               "https://github.com/akinsho/bufferline.nvim"])

(local lualine (require :lualine))
(local bufferline (require :bufferline))

(lualine.setup {:options {:theme :auto
                          :globalstatus true
                          :ignore_focus [:snacks_picker_list
                                         :snacks_picker_input
                                         :snacks_terminal]
                          :component_separators "│"
                          :section_separators ""}
                :sections {:lualine_b [{1 :branch :separator ""} :diff]
                           :lualine_c [{1 :filename :path 1}]
                           :lualine_x [:lsp_status
                                       {1 :diagnostics
                                        :sections [:error :warn]}
                                       :filetype]
                           :lualine_y [:selectioncount]}})

(bufferline.setup {:options {:style_preset bufferline.style_preset.no_italic
                             :tab_size 0}})
