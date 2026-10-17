(local snacks (require :snacks))
(local persistence (require :persistence))

(persistence.setup)
(vim.opt.sessionoptions:remove :blank)

(fn open-project [dir]
  (vim.fn.chdir dir)
  (vim.cmd.Oil dir))

(local ferris-art
       ["                  .   ,.                      "
        "              ;. .xo.:xd',do  '.              "
        "          ..  ddodddddddddddoodo  .           "
        "          :dooddddddddddddddddddldd           "
        "       c:,odddddllllllllllllllllllo:,:.       "
        "       ,oooooolllllllllllllllllllllllo        "
        "    .ccoooolllllllllllllllllllllllllllccc     "
        "     loollllllllllllllllllllllllllllllll.     "
        "  .;:lllllllllllllllllllllllclllllllllllc;,   "
        "   .lllllllllllll{WWl} .lllc{WW.} clllllllllll    "
        "  .:llllllllllll  {x},  :ll, {x}  'llllllccccc'   "
        " ,lllllllllllllll    .ccc:    ;ccccccccccccc;."
        "ccc. l.:cccccccc:;;;:cccccc,,:ccccccccc y' cc,"
        " .ll  l  ;c:;:dddd;,':cc:,;dddd;:;.:c. y  .c. "
        "   ll      c,ddcc dd'        ccdd,c.      yy  "
        "    ll       .cc:.          .;::'        yy   "
        "               '::;'.    ..,;;.         yy    "])

(local ferris
       (icollect [i part (ipairs (vim.split (table.concat ferris-art "\n")
                                            "[{}]"))]
         {1 part :hl (if (= (% i 2) 0) :GruvboxFg0 :GruvboxOrange)}))

(local version (let [v (vim.version)]
                 (.. "NVIM v" v.major "." v.minor "." v.patch)))

(local dashboard {:enabled true
                  :formats {:icon (fn [item]
                                    (if (= item.icon :directory)
                                        (doto (snacks.dashboard.icon item.file
                                                                     item.icon)
                                          (tset :hl :icon))
                                        {1 item.icon :width 2 :hl :icon}))}
                  :preset {:keys [{:icon " "
                                   :key :p
                                   :desc "Open Project"
                                   :action #(snacks.picker.projects)}
                                  {:icon "󰈞 "
                                   :key :f
                                   :desc "File Browser"
                                   :action ":Oil ."}
                                  {:icon " "
                                   :key :r
                                   :desc "Recent Files"
                                   :action #(snacks.picker.recent)}
                                  {:icon " "
                                   :key :g
                                   :desc "Find Text"
                                   :action #(snacks.picker.grep)}
                                  {:icon " "
                                   :key :c
                                   :desc :Config
                                   :action #(open-project (vim.fn.stdpath :config))}
                                  {:icon "󰦛 "
                                   :key :s
                                   :desc "Restore Session"
                                   :action #(persistence.load {:last true})}
                                  {:icon " "
                                   :key :q
                                   :desc :Quit
                                   :action ":qa"}]}
                  :sections [{:text ferris :align :center :padding 2}
                             {:title "Recent Projects"
                              :section :projects
                              :action open-project
                              :padding 1}
                             {:section :keys :padding 1}
                             {:text [{1 version :hl :GruvboxBg4}]
                              :align :center}]})

{: dashboard : open-project}
