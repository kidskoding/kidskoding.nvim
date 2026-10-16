(local snacks (require :snacks))
(local {: open-project : new-project} (require :config.snacks.projects))

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

{:enabled true
 :formats {:icon (fn [item]
                   (if (= item.icon :directory)
                       (doto (snacks.dashboard.icon item.file item.icon)
                         (tset :hl :icon))
                       {1 item.icon :width 2 :hl :icon}))}
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
                  :action #(open-project (vim.fn.stdpath :config))}
                 {:icon " " :key :q :desc :Quit :action ":qa"}]}
 :sections [{:text (shade ferris-art :GruvboxOrange :GruvboxFg0)
             :align :center
             :padding 1}
            {:text (shade wordmark-art :GruvboxFg1 nil :GruvboxBg2)
             :align :center
             :padding 2}
            {:title "Recent Projects"
             :section :projects
             :action open-project
             :padding 1}
            {:section :keys :padding 1}
            {:text [{1 version :hl :GruvboxBg4}] :align :center}]}
