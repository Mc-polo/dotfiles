abbr -a --position anywhere L '| ov'
abbr -a upgrade 'sudo apt update && sudo apt upgrade'
abbr -a open "xdg-open $1"
abbr -a ls 'eza --color=always --icons=always --long --header --git --time-style=relative --group-directories-first'
abbr -a ll 'eza -a --color=always --icons=always --long --header --git --time-style=relative --group-directories-first'
abbr -a lm 'eza -a -s modified --color=always --icons=always --long --header --git --time-style=relative'
abbr -a kt-up 'rsync -av /home/ville/skannaukset/kuulontuki/kitsas/KuulonTukiry-arkisto/* mcpolo@lakka.kapsi.fi:pub/kt'
