(vim.pack.add ["https://github.com/nvim-lualine/lualine.nvim"
               "https://github.com/nvim-tree/nvim-web-devicons"
               "https://github.com/akinsho/bufferline.nvim"
               "https://github.com/brenoprata10/nvim-highlight-colors"
               "https://github.com/folke/which-key.nvim"])

(local lualine (require :lualine))
(local bufferline (require :bufferline))
(local highlight-colors (require :nvim-highlight-colors))
(local which-key (require :which-key))

(highlight-colors.setup {:render :background :enable_tailwind true})

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
                             :separator_style ["" ""]
                             :offsets [{:filetype :snacks_layout_box
                                        :separator true
                                        :highlight :Normal}]}
                   :highlights {:indicator_selected {:fg "#d79921"}
                                :offset_separator {:bg (. (vim.api.nvim_get_hl 0
                                                                               {:name :Normal
                                                                                :link false})
                                                          :bg)}}})

;; leader group names. groups with no keymaps yet stay hidden
(which-key.setup {:spec [{1 :<leader>a :group :ai}
                         {1 :<leader>b :group :buffers}
                         {1 :<leader>c :group :code}
                         {1 :<leader>D :group :database :icon " "}
                         {1 :<leader>g :group :git}
                         {1 :<leader>m :group :markdown :icon " "}
                         {1 :<leader>o :group :obsidian :icon "󰠮 "}
                         {1 :<leader>r
                          :group :rust
                          :icon {:icon " " :color :orange}}
                         {1 :<leader>t :group :test :icon "󰙨 "}
                         {1 :<leader>T :group :typst :icon "󰈙 "}
                         {1 :<leader>x :group :lists :icon " "}]})

(vim.api.nvim_set_hl 0 :WhichKeyIcon {:fg "#B2CAED"})
