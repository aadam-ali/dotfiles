# Environment variables
export CONFIG="${HOME}/.config"
export XDG_CONFIG_HOME="${CONFIG}"
export EDITOR=vi
export GH_USER="aadam-ali"
export REPOS="${HOME}/Repos"
export TOOLS="${REPOS}/tools"
export DOTFILES="${REPOS}/${GH_USER}/dotfiles"
export SCRIPTS="${DOTFILES}/scripts"
export SB="${REPOS}/${GH_USER}/second-brain"
export HISTSIZE=5000
export HISTFILESIZE=10000

export ASDF_DATA_DIR="${TOOLS}/asdf"

# Aliases
alias ll="ls -lhA"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias me="cd ${REPOS}/${GH_USER}"
alias run="docker run -it --rm"
alias k="kubectl"
if [[ -x "$(command -v nvim)" ]]; then
  alias vi="nvim"
  alias code="nvim"
else
  alias vi="vim"
  alias code="vim"
fi

# Path
prefix_path() {
  for dir in $@; do
    test -d "$dir" || continue
    if [[ ":$PATH:" != *":$dir:"* ]]; then
      export PATH="$dir:$PATH"
    fi
  done
} && export -f prefix_path

suffix_path() {
  for dir in "$@"; do
    test -d "$dir" || continue
    if [[ ":$PATH:" != *":$dir:"* ]]; then
      export PATH="$PATH:$dir"
    fi
  done
} && export -f suffix_path

prefix_path \
  /opt/homebrew/opt/coreutils/libexec/gnubin \
  /opt/homebrew/opt/gnu-sed/libexec/gnubin \
  /opt/homebrew/opt/grep/libexec/gnubin \
  /opt/homebrew/opt/gnu-tar/libexec/gnubin \
  "/usr/local/go/bin" \
  "$HOME/go/bin" \
  "$ASDF_DATA_DIR/shims" \
  "$HOME/.local/bin" \
  "$HOME/bin" \
  "$SCRIPTS"

suffix_path \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/bin \
  /usr/sbin \
  /bin \
  /sbin \
  /usr/games \
  /usr/local/games \
  /snap/bin

# Enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f "/etc/bash_completion" ]]; then
    . /etc/bash_completion
  fi
fi

prompt() {
  # Colours
  bl='\[\e[30m\]' r='\[\e[31m\]' g='\[\e[32m\]' \
    y='\[\e[33m\]' b='\[\e[34m\]' p='\[\e[35m\]' \
    c='\[\e[36m\]' w='\[\e[37m\]' e='\[\e[0m\]' fg='\[\e[39m\]'

  # Bold colours
  bbl='\[\e[1;30m\]' br='\[\e[1;31m\]' bg='\[\e[1;32m\]' \
    by='\[\e[1;33m\]' bb='\[\e[1;34m\]' bp='\[\e[1;35m\]' \
    bc='\[\e[1;36m\]' bw='\[\e[1;37m\]' bfg='\[\e[1;39m\]'

  local branch changes aws_role fbranch venv aws_role_prompt wrap_length length

  branch="$(git branch --show-current 2>/dev/null)"
  changes="$(git status -su 2>/dev/null)"
  aws_role="${AWS_VAULT:-$AWS_PROFILE}"

  if [[ "${branch}" ]]; then
    if [[ "${changes}" ]]; then
      fbranch="${br}@${branch}${e}"
    else
      fbranch="${bg}@${branch}${e}"
    fi
    branch="${branch}"
  fi

  [[ -n "${VIRTUAL_ENV}" ]] && venv="${fg}(${VIRTUAL_ENV##*/})${e} "
  [[ -n "${aws_role}" ]] && aws_role_prompt="${fg} (${aws_role})${e}"

  wrap_length=$(($COLUMNS / 3))
  length="${venv}${aws_role}${PWD/$HOME/\~}${branch} ~> "

  if [[ ${#length} -lt ${wrap_length} ]]; then
    PS1="${venv}${bb}\w${e}${fbranch}${aws_role_prompt} ${bfg}~>${e} "
  else
    PS1="${venv}${bb}\w${e}${fbranch}${aws_role_prompt}\n${bfg}~>${e} "
  fi
}

export PROMPT_COMMAND="prompt"
