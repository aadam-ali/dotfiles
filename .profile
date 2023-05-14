# source .bashrc (sets prompt / env vars / aliases / other bash config)
if [[ -f "$HOME/.bashrc" ]]; then
  . "$HOME/.bashrc"
fi

# set local env vars / aliases / path
if [[ -f $HOME/.bash_local ]]; then
  . $HOME/.bash_local
fi
