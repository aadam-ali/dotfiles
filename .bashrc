# environment variables
export CONFIG="${HOME}/.config"
export EDITOR=vi
export GH_USER="Aadam-Ali"
export HOSTNAME="$(hostname)"
export REPOS="${HOME}/Repos"
export TOOLS="${REPOS}/tools"
export DOTFILES="${REPOS}/${GH_USER}/dotfiles"
export SCRIPTS="${DOTFILES}/scripts"
export NOTES="${REPOS}/${GH_USER}/notes"
export HISTSIZE=5000
export HISTFILESIZE=10000

# aliases
alias ll="ls -lhA"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias me="cd ${REPOS}/${GH_USER}"
alias run="docker run -it --rm"

# path
prefix_path() {
  for dir in $@; do
    test -d $dir || continue
    PATH=${PATH/":$dir:"/:}
    PATH=${PATH/#":$dir"/}
    PATH=${PATH/%":$dir"/}
    export PATH="$dir:$PATH"
  done
} && export -f prefix_path

suffix_path() {
  for dir in "$@"; do
    test -d $dir || continue
    PATH=${PATH/":$dir:"/:}
    PATH=${PATH/#":$dir"/}
    PATH=${PATH/%":$dir"/}
    export PATH="$PATH:$dir"
  done
} && export -f suffix_path

export PYENV_ROOT="$TOOLS/pyenv"

export TFENV_ROOT="$TOOLS/tfenv"

prefix_path \
  "$HOME/go/bin" \
  "$HOME/.local/bin" \
  "$HOME/bin" \
  "$PYENV_ROOT/bin" \
  "$TFENV_ROOT/bin" \
  "$HOME/Scripts"

suffix_path \
  /usr/local/opt/coreutils/libexec/gnubin \
  /usr/local/opt/gnu-sed/libexec/gnubin \
  /usr/local/opt/grep/libexec/gnubin \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/bin \
  /usr/sbin \
  /bin \
  /sbin \
  /usr/games \
  /usr/local/games \
  /snap/bin

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
  local fbranch venv

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

  length="${venv}${USER}@$(hostname):${PWD}${branch}$ "
  if [[ ${#length} -lt ${wrap_length} ]]; then
    PS1="${venv}${bg}\u@\h${e}:${bb}\w${e}${fbranch}\$ "
  else
    PS1="${venv}${bg}\u@\h${e}:${bb}\w${e}${fbranch}\n\$ "
  fi
}

export PROMPT_COMMAND="prompt"
