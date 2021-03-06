echo
fortune
echo
ddate +'%. Today is %{%A, the %e of %B%}, %Y. %N%nCelebrate %H'
echo



#
# Shell Options
#

shopt -s cdspell
shopt -s checkwinsize
shopt -s checkhash
shopt -s histappend histreedit histverify
shopt -s no_empty_cmd_completion
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignorespace:ignoredups:erasedups
umask 022

#
# Shell Prompt
#

export PS1='\[\e[0;36m\]\u\[\e[m\]\[\e[1;37m\]@\[\e[m\]\[\e[0;36m\]\h\[\e[m\] \[\e[1;37m\]\W\[\e[m\] \[\e[0;36m\]\$ \[\e[m\]\[\e[0;37m\]'

#
# Completion
#

source /usr/share/git/completion/git-completion.bash
source ~/.svn_completion

#
# Random Exports
#

export BROWSER=firefox
export EDITOR='emacsclient -t'
export PATH="$(ruby -rubygems -e "puts Gem.user_dir")/bin:/usr/lib/ccache/bin/:$PATH"

CDPATH=.:

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
alias cleantex='rm *+(.log|.aux|.bbl|.blg|.out|.toc)'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls)
#-------------------------------------------------------------
# dircolors
eval `dircolors -b $HOME/.dircolors`

alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |less'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'


alias copy='cp'


alias mkdir='mkdir -p'
alias grep='grep --colour'
alias rm='echo "This is not the command you are looking for."; false'

#
# Random
#


function ff () { find . -type f -iname '*'"$@"'*' ; }
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
# cgal tools
#-------------------------------------------------------------
export PATH="$PATH:$HOME/prog/cgal/Scripts/developer_scripts:$HOME/prog/cgal/Scripts/scripts"
export CGAL_DIR="$HOME/prog/cgal/build"

#-------------------------------------------------------------
# tailoring 'less'
#-------------------------------------------------------------

alias more='less'
export PAGER=less
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
   # Use this if lesspipe.sh exists
export LESS='-i -w -g -M -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
