# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ -f "$HOME/.ripgreprc" ]]; then
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
fi
