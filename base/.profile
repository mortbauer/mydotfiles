# shell neutral environment variable settings

# xdg_base variables point actually to default, maybe not needed, but need to
# check my vim configs
export ANDROID_HOME=/opt/android-sdk
export PATH=$HOME/workspace/bin:$HOME/bin:$HOME/.npm/bin:$HOME/.local/bin:$PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
# my favorite terminal in x
export TERMCMD="urxvt"
export GOPATH="$HOME/.go"
# {{{ Core Utilities , see: https://wiki.archlinux.org/index.php/Core_Utilities
# {{{ less
if [ -f /usr/bin/source-highlight-esc.sh ];
then
    export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
else
    export LESS_TERMCAP_me=$(printf '\e[0m')
    export LESS_TERMCAP_se=$(printf '\e[0m')
    export LESS_TERMCAP_ue=$(printf '\e[0m')
    export LESS_TERMCAP_mb=$(printf '\e[1;32m')
    export LESS_TERMCAP_md=$(printf '\e[1;34m')
    export LESS_TERMCAP_us=$(printf '\e[1;32m')
    export LESS_TERMCAP_so=$(printf '\e[1;44;1m')
fi
export LESS='-R '
# }}}
# {{{ ls
alias ls='ls --color=auto'
eval $(dircolors -b)
# }}}
# {{{ mv
alias mv=' timeout 8 mv -iv'
# }}}
# {{{ rm
#alias rm=' timeout 3 rm -Iv --one-file-system'
# }}}
# {{{ shred
alias shred=' timeout 3 shred -v'
# }}}
# {{{ editor
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export EDITOR="vim"
# }}}
alias ag="noglob ag"
# }}}
# {{{ Python
# virtualenv
alias pip="noglob pip"
# matplotlib
export MPLCONFIGDIR="${XDG_CONFIG_HOME}/matplotlib"
# }}}
# {{{ Aliases
alias youtube-dl="noglob youtube-dl"
alias tuvpn="sudo vpnc tu.conf"
alias webstudent="sshfs e0825649@web.student.tuwien.ac.at:/users/home49/e0825649 ~/webstudent/"
alias webstudentu="fusermount -u ~/webstudent/"

alias homestudent="sshfs e0825649@home.student.tuwien.ac.at:/users/home49/e0825649 ~/homestudent/"
alias homestudentu="fusermount -u ~/homestudent/"

alias fm4="mplayer http://mp3stream1.apasf.apa.at:8000"
alias fm4r="streamripper http://mp3stream1.apasf.apa.at:8000"

alias postmaster="martin"

alias deen="dict -d deu-eng"
alias ende="dict -d eng-deu"
alias gcide="dict -d gcide"

export WIKI="/data/InfoSys/Wiki/"
alias ewiki="ranger $WIKI/source"
alias uwiki="cd $WIKI; make html; cd -"

export DIPL_PATH="/home/martin/Documents/Studies/DIPL/ventilator/"

alias performance="sudo cpupower frequency-set -g performance"

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

#PATH="$PATH:$HOME/.rvm/bin:$(ruby -e 'puts Gem.user_dir')/bin:$PATH:$GOPATH/bin"
#export LD_PRELOAD="/home/martin/salome/Salome-V7_4_0-LGPL-x86_64/prerequisites/Hdf5_1810/lib/libhdf5.so:/home/martin/salome/Salome-V7_4_0-LGPL-x86_64/prerequisites/Hdf5_1810/lib/libhdf5_hl.so"

export CAE="cae.zserv.tuwien.ac.at"
export mat="e0825649"
export HPC="mortbauer.asuscomm.com"
alias get_esp32='export PATH="$PATH:$HOME/esp/xtensa-esp32-elf/bin";export IDF_PATH="$HOME/esp/pycom-esp-idf/"'

alias nbstrip_jq="jq --indent 1 \
    '(.cells[] | select(has(\"outputs\")) | .outputs) = []  \
    | (.cells[] | select(has(\"execution_count\")) | .execution_count) = null  \
    | .metadata = {\"language_info\": {\"name\": \"python\", \"pygments_lexer\": \"ipython3\"}} \
    | .cells[].metadata = {} \
    '"
sshProd (){
    ssh -i $HOME/.ssh/P/id_rsa -p 22022 root@$1
}
sshQual (){
    ssh -i $HOME/.ssh/Q/id_rsa -p 22023 root@$1
}
sshDev (){
    ssh -i $HOME/.ssh/D/id_rsa -p 22023 root@$1
}

alias tunProd="cd $HOME/schindler-ahead-support-vpn/ && sudo openvpn prdIoEE.ovpn"
alias tunQual="cd $HOME/schindler-ahead-support-vpn/ && sudo openvpn qulIoEE.ovpn"
alias tunDev="cd $HOME/schindler-ahead-support-vpn/ && sudo openvpn dvlIoEE.ovpn"
alias killtun="sudo killall openvpn"

export ARDUINO_DIR=/home/ortbauma/arduino-1.8.6/
export ARDUINO_PACKAGE_DIR=/home/ortbauma/.arduino15/packages/
export ARDMK_DIR=$HOME/workspace/tools/Arduino-Makefile
export AVR_TOOLS_DIR=/usr

alias lxc_stop_all_containers="lxc list | grep RUNNING | cut -f 2 -d '|' | sudo xargs lxc stop"

export PATH=$PATH:/usr/local/go/bin
alias mount_share="/usr/bin/vmhgfs-fuse .host:/share /home/ortbauma/workspace/share -o subtype=vmhgfs-fuse"
alias px="/home/ortbauma/workspace/tools/predix-cli/bin/linux64/predix"
