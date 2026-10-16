(vim.pack.add ["https://github.com/nvim-lualine/lualine.nvim"
               "https://github.com/nvim-tree/nvim-web-devicons"
               "https://github.com/akinsho/bufferline.nvim"])

(local lualine (require :lualine))
(local bufferline (require :bufferline))

(vim.api.nvim_set_hl 0 :lualine_sep_color_b {:fg "#a89984" :bg "#504945"})
(vim.api.nvim_set_hl 0 :lualine_sep_color_x {:fg "#a89984" :bg "#3c3836"})

(local theme (require :lualine.themes.gruvbox_dark))
(each [_ section (pairs theme)]
  (set section.c theme.normal.c))

(set theme.normal.a.bg "#d79921")
(each [mode section (pairs theme)]
  (when (not= mode :inactive)
    (set section.b.fg section.a.bg)))

(lualine.setup {:options {: theme
                          :globalstatus true
                          :ignore_focus [:snacks_picker_list
                                         :snacks_picker_input
                                         :snacks_terminal]
                          :component_separators {:left "%#lualine_sep_color_b#│"
                                                 :right "%#lualine_sep_color_x#│"}
                          :section_separators {:left "" :right ""}}
                :sections {:lualine_b [{1 :branch :separator ""} :diff]
                           :lualine_c [{1 :filename :path 1}]
                           :lualine_x [:lsp_status
                                       {1 :diagnostics
                                        :sections [:error :warn]}
                                       :filetype]
                           :lualine_y [:selectioncount]}})

(bufferline.setup {:options {:style_preset bufferline.style_preset.no_italic
                             :tab_size 0
                             :offsets [{:filetype :snacks_layout_box}]}})
