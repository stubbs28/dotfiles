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

prompt_cmd() {
  prompt_segment black default "╰󰁔"
}

## Main prompt
build_custom_prompt() {
  RETVAL=$?
  prompt_custom_status
  prompt_virtualenv
  prompt_kube
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}

build_cmd() {
  prompt_cmd
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_custom_prompt)
$(build_cmd) '
