## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

## jobs
setopt long_list_jobs

## pager
export PAGER=less
export LC_CTYPE=$LANG



# Advanced Find


function ff() {
    rg --line-number --color=always -n -e $1 --vimgrep | fzf -d ':' -n 2.. --ansi --no-sort --preview-window 'down:20%:+{2}' --preview 'bat --style=numbers --color=always --highlight-line {2} {1}'
}
