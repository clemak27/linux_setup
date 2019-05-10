# -> bashrc/profile
# if [ -f ~/.bash_aliases ]; then
#         . ~/.bash_aliases
# fi

# copy von vielen dateien
alias rsync-copy='rsync -avzh --progress '

# youtube musik runterladen
alias youtube-dl-music='youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'

# accidents happen
alias cd..="cd .."

# one letter
alias vim="nvim"

# some Git Aliases from bash.it
alias gcl='git clone'
alias ga='git add'
alias gf='git fetch --all --prune'
alias gus='git reset HEAD'
alias gm="git merge"
alias g='git'
alias gs='git status'
alias gl='git pull'
alias gpp='git pull && git push'
alias gp='git push'
alias gd='git diff'
alias gcm='git commit -v -m'
alias gb='git branch'
alias gbD='git branch -D'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias gwc="git whatchanged"
alias gt="git tag"