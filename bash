# To install:
# curl aguo.us/bash >| ~/.bashrc
# echo "source ~/.bashrc" >| ~/.bash_profile

# Exit if non-interactive
case $- in
    *i*) ;;
      *) return;;
esac

# General
alias bc='bc -l'
alias jt='python -m json.tool'
alias la='ls -A'
alias ll='ls -Al'
alias ls='ls -GFh --color=tty'
alias rm='rm -i'
alias bell='echo -e "\a"'
alias rlf='readlink -f'

# Moving around
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ,="cd -"

# History
export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

# Bash options
shopt -s cdspell
shopt -s globstar

# Screen/tmux
alias scl='screen -ls'
alias scr='screen -DRS'
alias drr='screen -dRR'
alias tml='tmux ls'
alias tmu='history -a; tmux new-session -A -s'

# Git
alias gs="git status"
alias gsuno="git status --untracked-files=no"
alias gcl="git clone"
alias gcls="git clone --depth 1"
alias gd="git diff"
alias gdc="git diff --cached"
alias gdl="git diff HEAD~ HEAD"
alias gdll="git diff HEAD~2 HEAD~"
alias gdlll="git diff HEAD~3 HEAD~2"
alias gdw="git diff --color-words='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'"
alias gf="git fetch"
alias gfa="git fetch --all"
alias ga="git add"
alias gau="git add -u"
alias gaa="git add -A"
alias gcm="git commit -m"
alias gcam="git add --all && git commit -am"
alias gcamn="git commit --amend"
alias gbv="git branch -v"
alias gch="git checkout"
alias gchb="git checkout -b"
alias grv="git remote -v"
alias gp="git push"
alias gpl="git pull"
alias gl="git log"
alias glgraph="git log --graph --abbrev-commit --decorate --date=relative --all"
alias glgraph1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias grhh="git reset --hard HEAD"
alias gcldf="git clean -df"

# Start SSH agent
SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
 eval `$SSHAGENT $SSHAGENTARGS` > /dev/null
 trap "kill $SSH_AGENT_PID" 0
fi

# Silent SimpleHTTPServer
function sf {
 python -m SimpleHTTPServer "$1" > /dev/null 2>&1 &
}

# Prompt colors
LIGHT_PURPLE="\[\033[1;35m\]"
LIGHT_CYAN="\[\033[1;36m\]"
NO_COLOR="\[\033[0m\]"

# Prompt
if [ -n "$STY" ]; then  # If inside a screen...
  PS1="\[\`if [[ \$? = "0" ]]; then echo '\n\e[32m\u@\h\e[0m'; else echo '\n\e[31m\u@\h\e[0m' ; fi\`:\w$LIGHT_CYAN\`__git_ps1 ' [%s]'\`$NO_COLOR $LIGHT_PURPLE[screen]$NO_COLOR\n\$ "
else
  PS1="\[\`if [[ \$? = "0" ]]; then echo '\n\e[32m\u@\h\e[0m'; else echo '\n\e[31m\u@\h\e[0m' ; fi\`:\w$LIGHT_CYAN\`__git_ps1 ' [%s]'\`$NO_COLOR\n\$ "
fi

# To finish installation:
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
# git clone https://github.com/rupa/z.git .zfiles

if [ -f ~/.git-prompt.sh ]; then source ~/.git-prompt.sh; else alias __git_ps1='echo "$1" > /dev/null'; fi
if [ -f ~/.git-completion.bash ]; then source ~/.git-completion.bash; fi
if [ -f ~/.zfiles/z.sh ]; then . ~/.zfiles/z.sh; fi
