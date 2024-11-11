if [[ -f /etc/profile ]]; then
  PATH="/usr/local/bin:/usr/bin:/bin"
  source /etc/profile
fi

# source .bashrc (sets prompt / env vars / aliases / other bash config)
if [[ -f "$HOME/.bashrc" ]]; then
  . "$HOME/.bashrc"
fi

# set local env vars / aliases / path
if [[ -f $HOME/.bash_local ]]; then
  . $HOME/.bash_local
fi

export XDG_CONFIG_HOME="${HOME}/.config"
[[ -d $PYENV_ROOT ]] && eval "$(pyenv init -)"
