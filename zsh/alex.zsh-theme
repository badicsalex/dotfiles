# alex.zsh-theme
# Copyright Alex Badics 2015-2019
# Yeah, since the Balabit times.

alex_theme_magic_path(){
    echo -n "-(%B%F{white}"
    if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" && $(command git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]]; then
        dir_name="$(git rev-parse --show-toplevel)%F{39}/$(git rev-parse --show-prefix)"
    else
        dir_name="$(pwd)"
    fi
    [[ "$dir_name" =~ ^"$HOME"(/|$) ]] && dir_name="~${dir_name#$HOME}"
    echo -n $dir_name
    echo -n "%b%f)"
}

alex_theme_chroot_kieg(){
    [ "$SCHROOT_CHROOT_NAME" ] && echo -n " - %B%F{red}$SCHROOT_CHROOT_NAME%b%f"
}

alex_theme_colored_user_pw(){
    echo -n "["
    if [[ $UID -ne 0 ]]; then
        echo -n "%n"
    else
        echo -n "%B%F{red}%n%b%f"
    fi

    echo -n "@"
    if [[ -n "$SSH_CLIENT" ]]; then
        echo -n "%F{39}%M %F{25}(from ${SSH_CLIENT%% *})%f"
    else
        echo -n "%M"
    fi
    alex_theme_chroot_kieg
    echo -n "]"
}

function alex_git_prompt_stash_count(){
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    echo -n "$ZSH_THEME_GIT_STASH_COUNT_BEFORE$(git stash list | wc -l)$ZSH_THEME_GIT_STASH_COUNT_AFTER"
  fi
}

function alex_git_prompt_info() {
    local ref
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$(git_prompt_short_sha)$(alex_git_prompt_stash_count)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

local ret_color="%B%(?:%F{green}:%F{red})"
PROMPT='%k%f┌$(alex_theme_colored_user_pw)$(alex_theme_magic_path)$(virtualenv_prompt_info)$(alex_git_prompt_info)-[%T]
└${ret_color}>%b%f '

ZSH_THEME_VIRTUALENV_PREFIX="-[%B%F{25}"
ZSH_THEME_VIRTUALENV_SUFFIX="%b%f]"
ZSH_THEME_GIT_PROMPT_PREFIX="-[%B%F{39}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%f]"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %B%F{25}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%b%f"
ZSH_THEME_GIT_STASH_COUNT_BEFORE="%F{39} ≡ "
ZSH_THEME_GIT_STASH_COUNT_AFTER="%b%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %B%F{red}✗%b%f"
ZSH_THEME_GIT_PROMPT_CLEAN=" %B%F{green}✔%b%f"
