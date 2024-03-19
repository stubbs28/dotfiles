# vim:ft=zsh ts=2 sw=2 sts=2
#
# stickers's Theme, a customm edit of agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

source "$ZSH/themes/agnoster.zsh-theme"

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown
#
# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_custom_status() {
  local -a symbols

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}󱐋"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}"

  prompt_segment black default "╭─$symbols"
}

# Kube: current kubernetes context
prompt_kube() {
	if hash kubectl 2>/dev/null; then
		context="$(kubectl config current-context)"
	fi
	[[ -z "$context" ]] && return
	prompt_segment green black "$context"
}

prompt_custom_git() {
  (( $+commands[git] )) || return
  if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref dirty mode repo_path

   if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    if [[ "$(git config --get oh-my-zsh.hide-dirty 2>/dev/null)" -ne 1 ]]; then
      dirty=$(parse_git_dirty)
    fi
    ref=$(git symbolic-ref HEAD 2> /dev/null) || \
    ref="◈ $(git describe --exact-match --tags HEAD 2> /dev/null)" || \
    ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green $CURRENT_FG
    fi

    local ahead behind
    ahead=$(git log --oneline @{upstream}.. 2>/dev/null)
    behind=$(git log --oneline ..@{upstream} 2>/dev/null)
    if [[ -n "$ahead" ]] && [[ -n "$behind" ]]; then
      PL_BRANCH_CHAR=$'\u21c5'  # ⇅
    elif [[ -n "$ahead" ]]; then
      PL_BRANCH_CHAR=$'\u21b1'  # ↱
    elif [[ -n "$behind" ]]; then
      PL_BRANCH_CHAR=$'\u21b0'  # ↰
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    if [[ "$(git config --get oh-my-zsh.hide-dirty 2>/dev/null)" -ne 1 ]]; then
      zstyle ':vcs_info:*' check-for-changes true
      zstyle ':vcs_info:*' stagedstr '✚'
      zstyle ':vcs_info:*' unstagedstr '±'
    fi
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${${ref:gs/%/%%}/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
  fi
}

prompt_cmd() {
  prompt_segment black default "╰─"
}

## Main prompt
build_custom_prompt() {
  RETVAL=$?
  prompt_custom_status
  prompt_virtualenv
  prompt_kube
  prompt_context
  prompt_dir
  prompt_custom_git
  prompt_end
}

build_cmd() {
  prompt_cmd
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_custom_prompt)
$(build_cmd) '
