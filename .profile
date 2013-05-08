alias ls="ls -G"
alias ll="ls -Al"

alias mystart="sudo /opt/local/bin/mysqld_safe5 &"
alias mystop="/opt/local/bin/mysqladmin5 -u root -p shutdown"

alias vim='mvim'
alias serve='python -m SimpleHTTPServer'

source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh

export PS1='\[\e]2;\u@\H \w\a\[\e[31;1m\]\u:\[\e[0m\e[36m\]\w\[\e[0m\]$(__git_ps1 " (%s)")\$ '

# Setting PATH for Python 2.7
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

[[ -s "/Users/zachgotsch/.rvm/scripts/rvm" ]] && source "/Users/zachgotsch/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export EDITOR='vim'
export GREP_OPTIONS='-n --color=auto'

