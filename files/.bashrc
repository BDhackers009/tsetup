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
export PROMPT_COMMAND=set_bash_prompt

source /data/data/com.termux/files/usr/share/fzf/completion.bash
source /data/data/com.termux/files/usr/share/fzf/key-bindings.bash
export FZF_DEFAULT_OPTS="--height=43% --layout=reverse --info=inline --border --margin=1 --padding=1"
# custom material theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#eceff1,bg:#263238,hl:#5f87af --color=fg+:#eceff1,bg+:#262626,hl+:#5fd7ff --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'