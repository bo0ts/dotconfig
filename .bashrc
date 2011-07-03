echo
fortune
echo
ddate +'Today is %{%A, the %e of %B%}, %Y. %N%nCelebrate %H'
echo

#
# Shell Options
#

shopt -s cdspell
shopt -s checkwinsize
shopt -s checkhash
shopt -s histappend histreedit histverify
shopt -s no_empty_cmd_completion
export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTCONTROL=ignoredups
umask 022

#
# Shell Prompt
#

export PS1='\[\e[0;36m\]\u\[\e[m\] \[\e[1;37m\]\w\[\e[m\] \[\e[0;36m\]\$ \[\e[m\]\[\e[0;37m\]'
export PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'

#
# Completion
#

#[ -f /etc/bash_completion ] && source /etc/bash_completion
#complete -cf sudo
#complete -cf man
source ~/.git-bash-completion.sh
source ~/.svn_completion

#
# Random Exports
#

export BROWSER=firefox
export EDITOR='emacs -nw -q'
export PATH=$PATH:/usr/local/bin:$HOME/.cabal/bin
CDPATH=.:
export FANTOMDATADIR=/home/boots/fantom/trunk/testData/
export FANTOMBASEDIR=/home/boots/fantom/trunk/

#
# Alias Zone
#

alias ..='cd ..'
alias du='du -kh'
alias df='df -kTh'
alias ps='ps'
alias ping='ping -c 5'
alias f='find . -type f -name'
alias cal='cal -m'
alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'
alias cleantex='rm *+(.log|.aux)'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls)
#-------------------------------------------------------------
alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'


alias copy='cp'


alias mkdir='mkdir -p'
alias grep='grep --colour'
alias g="grep"

#
# Random
#


function ff () { find . -type f -iname '*'"$@"'*' ; }
function firefox() { command firefox "$@" & }
function xpdf() { command xpdf "$@" & }
function xchm() { command xchm "$@" & }
function extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}



#-------------------------------------------------------------
# tailoring 'less'
#-------------------------------------------------------------

alias more='less'
export PAGER=less
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
   # Use this if lesspipe.sh exists
export LESS='-i -w -g -M -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'