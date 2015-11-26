# General
alias py='python'
alias jt='python -m json.tool'
alias ls='ls -GFh --color=tty'
alias la='ls -A'
alias lsal='ls -al'
alias rm='rm -i'
alias vi='vim'

# Git
alias gs="git status" 
alias gcl="git clone" 
alias gd="git diff" 
alias gdc="git diff --cached"
alias gdl="git diff HEAD~ HEAD"
alias gf="git fetch"
alias gfa="git fetch --all"
alias ga="git add"
alias gc="git commit" 
alias gcm="git commit -m" 
alias gcam="git add --all && git commit -am"
alias gcamn="git commit --amend"
alias gbv="git branch -v" 
alias gch="git checkout" 
alias gchb="git checkout -b" 
alias gchm="git checkout master"
alias gm="git merge"
alias gmm="git merge master"
alias gp="git push" 
alias gpom="git push origin master" 
alias gpl="git pull" 
alias gl="git log" 
alias glgraph="git log --graph --abbrev-commit --decorate --date=relative --all"
alias glgraph1="git log --graph --oneline --decorate --date=relative --all" 
alias grhh="git reset --hard HEAD"
alias grbi="git rebase -i"

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

