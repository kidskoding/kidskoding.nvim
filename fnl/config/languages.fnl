(set vim.g.rustaceanvim
     {:server {:default_settings {:rust-analyzer {:cargo {:allFeatures true}
                                                  :check {:command :clippy}}}}})

(vim.pack.add ["https://github.com/mrcjkb/rustaceanvim"
               "https://github.com/chomosuke/typst-preview.nvim"
               "https://github.com/MeanderingProgrammer/render-markdown.nvim"
               {:src "https://github.com/obsidian-nvim/obsidian.nvim"
                :version (vim.version.range "*")}])

(local typst-preview (require :typst-preview))
(local render-markdown (require :render-markdown))
(local obsidian (require :obsidian))

;; use tinymist and websocat from PATH instead of downloading them
(typst-preview.setup {:dependencies_bin {:tinymist :tinymist
                                         :websocat :websocat}})

(render-markdown.setup {:latex {:enabled false}})

(obsidian.setup {:legacy_commands false
                 :workspaces [{:name :vault :path "~/Obsidian Vault"}]
                 :picker {:name :snacks.picker}
                 :ui {:enable false}
                 :frontmatter {:enabled false}})

(vim.keymap.set :n :<leader>of "<cmd>Obsidian quick_switch<CR>"
                {:desc "Find note"})

(vim.keymap.set :n :<leader>os "<cmd>Obsidian search<CR>"
                {:desc "Search notes"})

(vim.keymap.set :n :<leader>on "<cmd>Obsidian new<CR>" {:desc "New note"})
(vim.keymap.set :n :<leader>od "<cmd>Obsidian today<CR>" {:desc "Daily note"})
(vim.keymap.set :n :<leader>ob "<cmd>Obsidian backlinks<CR>" {:desc :Backlinks})
(vim.keymap.set :n :<leader>ot "<cmd>Obsidian tags<CR>" {:desc "Search tags"})

(fn open-typst-pdf []
  (let [client (. (vim.lsp.get_clients {:name :tinymist :bufnr 0}) 1)]
    (if (not= vim.bo.filetype :typst)
        (vim.notify "Open a Typst file first" vim.log.levels.WARN)
        (= (vim.fn.executable :zathura) 0)
        (vim.notify "Zathura is not installed" vim.log.levels.ERROR)
        (not client)
        (vim.notify "Tinymist is still starting; try again shortly"
                    vim.log.levels.WARN)
        (client:request :workspace/executeCommand
                        {:command :tinymist.exportPdf
                         :arguments [(vim.api.nvim_buf_get_name 0)]}
                        (fn [err result]
                          (if (or err (not result)
                                  (not= (type result.path) :string))
                              (vim.notify (.. "PDF export failed: "
                                              (or (?. err :message)
                                                  "check Typst diagnostics"))
                                          vim.log.levels.ERROR)
                              (do
                                (when (and vim.g.zathura_job
                                           (= (. (vim.fn.jobwait [vim.g.zathura_job]
                                                                 0)
                                                 1)
                                              -1))
                                  (vim.fn.jobstop vim.g.zathura_job))
                                (set vim.g.zathura_job
                                     (vim.fn.jobstart [:zathura result.path]
                                                      {:detach true})))))
                        0))))

(fn map [key action desc]
  (vim.keymap.set :n key action {: desc}))

(map :<leader>ra "<cmd>RustLsp codeAction<CR>" "Rust code action")
(map :<leader>rr "<cmd>RustLsp runnables<CR>" "Rust runnables")
(map :<leader>rt "<cmd>RustLsp testables<CR>" "Rust testables")
(map :<leader>re "<cmd>RustLsp explainError<CR>" "Explain Rust error")
(map :<leader>Tp open-typst-pdf "Open Typst PDF in Zathura")
(map :<leader>TP :<cmd>TypstPreviewToggle<CR> "Toggle Typst browser preview")

(map :<leader>mr "<cmd>RenderMarkdown toggle<CR>" "Toggle Markdown render")
(map :<leader>mp "<cmd>RenderMarkdown preview<CR>" "Markdown preview split")
