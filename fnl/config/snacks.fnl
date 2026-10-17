(vim.pack.add ["https://github.com/folke/snacks.nvim"
               "https://github.com/folke/todo-comments.nvim"
               "https://github.com/folke/persistence.nvim"])

(local snacks (require :snacks))
(local {: dashboard : open-project} (require :config.dashboard))

(snacks.setup {:bigfile {:enabled true}
               : dashboard
               :indent {:enabled true}
               :lazygit {:configure false}
               :styles {:lazygit {:wo {:winhighlight "NormalFloat:Normal"}}}
               :picker {:enabled true
                        :sources {:explorer {:hidden true :ignored true}
                                  :projects {:confirm (fn [picker item]
                                                        (picker:close)
                                                        (when item
                                                          (open-project item.file)))
                                             :dev ["~/uiuc/go-mama-27/personal-projects"
                                                   "~/uiuc"
                                                   "~/contributing"
                                                   "~/playground"]}}}})

(let [icon snacks.util.icon]
  (set snacks.util.icon (fn [name cat opts]
                          (icon (if (= cat :file) (vim.fs.basename name) name)
                                cat opts))))

;; after snacks.setup so todo-comments registers its picker source
((. (require :todo-comments) :setup) {})

(fn map [key action desc]
  (vim.keymap.set :n key action {: desc}))

(map :<leader><space> #(snacks.picker.files) "Find files")
(map :<leader>/ #(snacks.picker.grep) "Search project")
(map :<leader>e #(snacks.picker.explorer) "File explorer")
(map :<leader>p #(snacks.picker.projects) "Switch project")
(map :<leader>h #(snacks.picker.help) "Search help pages")
(map :<leader>bb #(snacks.picker.buffers) "Switch buffer")
(map :<leader>bd #(snacks.bufdelete) "Close buffer")
(map :<leader>gz #(snacks.lazygit) :Lazygit)
(map :<leader>gB #(snacks.gitbrowse) "Open file on GitHub")
(map :<leader>gl #(snacks.picker.git_log_file) "File git history")
(map :<leader>xt #(snacks.picker.todo_comments) "Todo list")
(map :<leader>. #(snacks.scratch) "Toggle scratch buffer")
(map :<leader>S #(snacks.scratch.select) "Select scratch buffer")

(map :gd #(snacks.picker.lsp_definitions) "Go to definition")
(map :grr #(snacks.picker.lsp_references) :References)

;; some terminals send <C-_> for <C-/>
(vim.keymap.set [:n :t] :<C-/> #(snacks.terminal) {:desc "Toggle terminal"})
(vim.keymap.set [:n :t] :<C-_> #(snacks.terminal) {:desc :which_key_ignore})

;; add jk escape sequence for terminals, EXCEPT for lazygit!
(vim.api.nvim_create_autocmd :TermOpen
                             {:callback (fn [ev]
                                          (when (not (string.find ev.match
                                                                  :lazygit))
                                            (vim.keymap.set :t :jk
                                                            "<C-\\><C-n>"
                                                            {:buffer ev.buf
                                                             :desc "Exit terminal mode"})))})
