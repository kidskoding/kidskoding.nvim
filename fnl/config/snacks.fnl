(vim.pack.add ["https://github.com/folke/snacks.nvim"
               "https://github.com/folke/todo-comments.nvim"])

(local snacks (require :snacks))

(local ferris-art
       ["                  .   ,."
        "              ;. .xo.:xd',do  '."
        "          ..  ddodddddddddddoodo  ."
        "          :dooddddddddddddddddddldd"
        "       c:,odddddllllllllllllllllllo:,:."
        "       ,oooooolllllllllllllllllllllllo"
        "    .ccoooolllllllllllllllllllllllllllccc"
        "     loollllllllllllllllllllllllllllllll."
        "  .;:lllllllllllllllllllllllclllllllllllc;,"
        "   .lllllllllllll{WWl} .lllc{WW.} clllllllllll"
        "  .:llllllllllll  {x},  :ll, {x}  'llllllccccc'"
        " ,lllllllllllllll    .ccc:    ;ccccccccccccc;."
        "ccc. l.:cccccccc:;;;:cccccc,,:ccccccccc y' cc,"
        " .ll  l  ;c:;:dddd;,':cc:,;dddd;:;.:c. y  .c."
        "   ll      c,ddcc dd'        ccdd,c.      yy"
        "    ll       .cc:.          .;::'        yy"
        "               '::;'.    ..,;;.         yy"])

(local wordmark-art
       ["░█▀▀░█▀▀░█▀▄░█▀▄░▀█▀░█▀▀░"
        "░█▀▀░█▀▀░█▀▄░█▀▄░░█░░▀▀█░"
        "░▀░░░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░"])

(fn shade [lines base accent texture]
  (let [width #(vim.api.nvim_strwidth (pick-values 1 (string.gsub $ "[{}]" "")))
        max-width (accumulate [w 0 _ line (ipairs lines)]
                    (math.max w (width line)))
        chunks []]
    (var in-accent false)
    (each [i line (ipairs lines)]
      (when (> i 1)
        (table.insert chunks ["\n"]))
      (let [padded (.. line (string.rep " " (- max-width (width line))))]
        (each [_ char (ipairs (vim.fn.split padded "\\zs"))]
          (if (or (= char "{") (= char "}"))
              (set in-accent (= char "{"))
              (let [hl (if (= char "░") texture
                           in-accent accent
                           base)
                    last (. chunks (length chunks))]
                (if (and last (= last.hl hl))
                    (tset last 1 (.. (. last 1) char))
                    (table.insert chunks {1 char : hl})))))))
    chunks))

(local version (let [v (vim.version)]
                 (.. :v v.major "." v.minor "." v.patch)))

(fn open-project [dir]
  (vim.fn.chdir dir)
  (when (= vim.bo.filetype :snacks_dashboard)
    (vim.cmd.enew))
  (snacks.picker.explorer))

(fn new-project []
  (let [default (.. (vim.fn.fnamemodify (vim.fn.getcwd) ":~") "/")]
    (vim.ui.input {:prompt "New project: " : default :completion :dir}
                  (fn [path]
                    (when (and path
                               (not= (vim.fn.expand path)
                                     (vim.fn.expand default)))
                      (let [dir (vim.fs.normalize (vim.fn.expand path))]
                        (when (= 0 (vim.fn.isdirectory dir))
                          (vim.fn.mkdir dir :p)
                          (vim.fn.system [:git :init dir]))
                        (vim.notify (.. "Project: "
                                        (vim.fn.fnamemodify dir ":~")))
                        (open-project dir)))))))

(snacks.setup {:bigfile {:enabled true}
               :dashboard {:enabled true
                           :formats {:icon (fn [item]
                                             (if (= item.icon :directory)
                                                 (doto (snacks.dashboard.icon item.file
                                                                              item.icon)
                                                   (tset :hl :icon))
                                                 {1 item.icon
                                                  :width 2
                                                  :hl :icon}))}
                           :preset {:keys [{:icon "󰉗 "
                                            :key :n
                                            :desc "New Project"
                                            :action new-project}
                                           {:icon " "
                                            :key :p
                                            :desc "Open Project"
                                            :action #(snacks.picker.projects)}
                                           {:icon " "
                                            :key :c
                                            :desc :Config
                                            :action #(snacks.dashboard.pick :files
                                                                            {:cwd (vim.fn.stdpath :config)})}
                                           {:icon " "
                                            :key :q
                                            :desc :Quit
                                            :action ":qa"}]}
                           :sections [{:text (shade ferris-art :GruvboxOrange
                                                    :GruvboxFg0)
                                       :align :center
                                       :padding 1}
                                      {:text (shade wordmark-art :GruvboxFg1
                                                    nil :GruvboxBg2)
                                       :align :center
                                       :padding 2}
                                      {:title "Recent Projects"
                                       :section :projects
                                       :action open-project
                                       :padding 1}
                                      {:section :keys :padding 1}
                                      {:text [{1 version :hl :GruvboxBg4}]
                                       :align :center}]}
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
