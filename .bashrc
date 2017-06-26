# SOURCE GLOBAL DEFINITIONS
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# BASH OPTIONS
shopt -s checkwinsize            # Update windows size on command
shopt -s histappend              # Append History instead of overwriting file
shopt -s cmdhist                 # Bash attempts to save all lines of a multiple-line command in the same history entry
shopt -s extglob                 # Extended pattern
shopt -s no_empty_cmd_completion # No empty completion

# COMPLETION
complete -cf sudo
if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi

# ALIAS
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
  
alias l='ls -lah --color=auto'
alias cls='clear'
