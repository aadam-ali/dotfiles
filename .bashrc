# environment variables
export CONFIG="${HOME}/.config"
export EDITOR=vi
export GH_USER="Aadam-Ali"
export HOSTNAME="$(hostname)"
export REPOS="${HOME}/Repos"
export DOTFILES="${REPOS}/${GH_USER}/dotfiles"
export SCRIPTS="${DOTFILES}/scripts"
export NOTES="${REPOS}/${GH_USER}/notes"

# aliases
alias ll="ls -lhA"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias me="cd ${REPOS}/${GH_USER}"
alias run="docker run -it --rm"

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f "/etc/bash_completion" ]]; then
    . /etc/bash_completion
  fi
fi

# prompt
bl='\[\e[30m\]' r='\[\e[31m\]' g='\[\e[32m\]' \
y='\[\e[33m\]' b='\[\e[34m\]' p='\[\e[35m\]' \
c='\[\e[36m\]' w='\[\e[37m\]' e='\[\e[0m\]'

bbl='\[\e[1;30m\]' br='\[\e[1;31m\]' bg='\[\e[1;32m\]' \
by='\[\e[1;33m\]' bb='\[\e[1;34m\]' bp='\[\e[1;35m\]' \
bc='\[\e[1;36m\]' bw='\[\e[1;37m\]' 

prompt () {
  local fbranch venv dir="${PWD##*/}"

  branch="$(git branch --show-current 2>/dev/null)"
  changes="$(git status -su 2>/dev/null)"

  [[ "${PWD}" == "${HOME}" ]] && dir="~"

  if [[ "${branch}" ]]; then
    if [[ "${changes}" ]]; then
      fbranch="(${r}${branch}${e})"
    else
      fbranch="(${g}${branch}${e})"
    fi
    branch="(${branch})"
  fi

  if [[ "${VIRTUAL_ENV}" ]]; then
    venv="(${VIRTUAL_ENV##*/}) "
  fi

  wrap_length=$(( $COLUMNS / 2 ))

  length="${venv}${USER}@$(hostname):${dir}${branch}$ "
  if [[ ${#length} < ${wrap_length} ]]; then
    PS1="${venv}${bg}\u@\h${e}:${bb}\W${e}${fbranch}\$ "
  else
    PS1="${venv}${bg}\u@\h${e}:${bb}\W${e}${fbranch}\n\$ "
  fi
}

export PROMPT_COMMAND="prompt"

# WSL2 specific settings
if [[ "$(uname -r)" =~ "microsoft" ]]; then
  /usr/bin/keychain -q --nogui $HOME/.ssh/github
  source "${HOME}/.keychain/${HOSTNAME}-sh"
fi
