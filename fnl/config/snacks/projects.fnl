(local snacks (require :snacks))

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

{: open-project : new-project}
