#!/data/data/com.termux/files/usr/bin/bash
GRAY="\e[2;37m"
GREEN="\e[0;32m"
PURPLE="\e[1;35m"
COLOR_NONE="\e[0m"

# Detect whether the current directory is a git repository.
function is_git_repository() {
  git branch > /dev/null 2>&1
}

function set_git_branch () {
    # Note that for new repo without commit, git rev-parse --abbrev-ref HEAD
    # will error out.
    if git rev-parse --abbrev-ref HEAD > /dev/null 2>&1; then
        BRANCH=$(git rev-parse --abbrev-ref HEAD)
    else
        BRANCH="bare repo!"
    fi
}

function set_bash_prompt () {

    if is_git_repository; then
        set_git_branch
    else
        BRANCH=''
    fi

    PS1=""
    PS1+="\[$GRAY\]\u@\h\[$COLOR_NONE\] "
    PS1+="\[$COLOR_NONE\] in \[$COLOR_NONE\]"
    PS1+="\[$GREEN\]\W\[$COLOR_NONE\] "
    PS1+="\[$GRAY\]\[$BRANCH\]\[$COLOR_NONE\]\n"
    PS1+="\[$PURPLE\]>\[$COLOR_NONE\] "

}
bind TAB:menu-complete
bind -x '"\C-\o": fcd'

export PROMPT_COMMAND=set_bash_prompt
#Source fzf files.
source /data/data/com.termux/files/usr/share/fzf/completion.bash
source /data/data/com.termux/files/usr/share/fzf/key-bindings.bash
export FZF_DEFAULT_OPTS="--height=45% --layout=reverse --info=inline --border --margin=1 --padding=1"
# custom material theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#eceff1,bg:#263238,hl:#5f87af --color=fg+:#eceff1,bg+:#262626,hl+:#5fd7ff --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'

fcd() {
    >/dev/null cd $1
    if [ -z $1 ]
    then
        while true;
        do
            selection="$(exa -a --group-directories-first | fzf --prompt "$(pwd)/" --preview ' cd_pre="$(echo $(pwd)/$(echo {}))";
                    echo $cd_pre;
                    echo;
                    exa -a --group-directories-first --color=always "${cd_pre}";
                    bat --style=numbers --color=always {} 2>/dev/null' --bind alt-down:preview-down,alt-up:preview-up --preview-window=right:65%)"
        if [[ -d "$selection" ]]
        then
            >/dev/null cd "$selection"
        elif [[ -f "$selection" ]]
        then
            for file in $selection;
            do
                if [[ $file == *.txt ]] || [[ $file == *.sh ]] || [[ $file == *.lua ]] || [[ $file == *.conf ]] || [[ $file == .*rc ]] || [[ $file == *rc ]] || [[ $file == autostart ]] || [[ $file == *.tex ]] || [[ $file == *.py ]]
                then
                    nano "$selection"
                elif [[ $file == *.docx ]] || [[ $file == *.odt ]]
                then
                    termux-open "$selection" 2>/dev/null
                elif [[ $file == *.pdf ]]
                then
                    termux-open "$selection"
                elif [[ $file == *.jpg ]] || [[ $file == *.png ]] || [[ $file == *.xpm ]] || [[ $file == *.jpeg ]]
                then
                    termux-open "$selection"
                else [[ $file == *.xcf ]]
                    termux-open "$selection"
            fi
        done
        else
            break
        fi
    done
    fi
}

# Aliases
# replace ls,grep,find,cat to exa,ripgrep,fd,bat

alias ls="eza --icons --group-directories-first"
alias l="ls"
alias la="ls -a"
alias ll="ls -lah"
alias cat="bat -p"
alias find="fd"
alias grep="rg"

