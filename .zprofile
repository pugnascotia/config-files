# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ -d "$HOME/Library/Application Support/Coursier/bin" ]]; then 
  export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
fi

if [[ -f "$HOME/.ripgreprc" ]]; then
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
fi
