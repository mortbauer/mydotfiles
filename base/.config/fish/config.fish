#source $HOME/.profile
export PATH="$PATH:/home/martin/.local/bin:/opt/google-cloud-sdk/bin:/opt/blender/blender-2.90.0-linux64/"
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython

# Some Useful Aliases
alias c="clear;ls"
alias ct="clear;tree"
alias lsa="ls -ltra"
alias lss="ls -ltra|less"
alias la="ls -lsa|less"
alias cls="clear"
alias e="exit"
#alias gs="git status -uno"

# Custom Pythonista Prompt
set -l magenta (set_color -o magenta)
set -l yellow (set_color -o yellow)
set -l green (set_color -o green)
set -l gray (set_color -o black)
set -l normal (set_color normal)


# Git Stats
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
 
# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'
 
function fish_prompt
    printf '%s ' (__fish_git_prompt)
    set_color yellow
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color magenta
    printf '%s' (hostname|cut -d . -f 1)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    # Line 2
    echo
    if test $VIRTUAL_ENV
    printf "" (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end
    printf '↪ '
end
