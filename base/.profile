# shell neutral environment variable settings

# xdg_base variables point actually to default, maybe not needed, but need to
# check my vim configs
#export PATH=$HOME/bin:$HOME/.local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export TERMCMD="urxvt"
export GOPATH="$HOME/.go"
alias ls='ls --color=auto'
# add some security
alias mv=' timeout 8 mv -iv'
alias rm=' timeout 3 rm -Iv --one-file-system'
alias shred=' timeout 3 shred -v'
# editor
export EDITOR="vim"
alias ag="noglob ag"
alias pip="noglob pip"
# matplotlib
export MPLCONFIGDIR="$XDG_CONFIG_HOME/matplotlib"
alias youtube-dl="noglob youtube-dl"

alias fm4="mplayer http://mp3stream1.apasf.apa.at:8000"
alias fm4r="streamripper http://mp3stream1.apasf.apa.at:8000"

alias deen="dict -d deu-eng"
alias ende="dict -d eng-deu"
alias gcide="dict -d gcide"

export WIKI="/data/InfoSys/Wiki/"
alias ewiki="ranger $WIKI/source"
alias uwiki="cd $WIKI; make html; cd -"

export DIPL_PATH="/home/martin/Documents/Studies/DIPL/ventilator/"

alias performance="sudo cpupower frequency-set -g performance"
alias permissions='stat -c "%A %a %n"'

alias fmail='offlineimap -c ~/.config/offlineimap/offlineimap.conf'
export OF23_BASHRC="/home/martin/opt/OpenFOAM/OpenFOAM-2.3.x/etc/bashrc"
alias of23='source $OF23_BASHRC;source $WM_PROJECT_DIR/bin/tools/RunFunctions'

export OFX_BASHRC="/home/martin/OpenFOAM/OpenFOAM-2.3.x/etc/bashrc"
alias ofx='source $OFX_BASHRC;source $WM_PROJECT_DIR/bin/tools/RunFunctions'

export OFEX_BASHRC="/home/martin/OpenFOAM/foam-extend-3.1/etc/bashrc"
alias ofex='source $OFEX_BASHRC'

export PARAVIEW_LIBDIR="/usr/lib/paraview-4.2/"
# code saturne
alias cs_prod="/home/martin/opt/code_saturne-production/bin/code_saturne"
alias cs_deb="/home/martin/opt/code_saturne-svn-debug/bin/code_saturne"
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
# }}}

