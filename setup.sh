#!/bin/zsh

echo "⚠️  This script is optimized for Zsh. If you're using a different shell, behavior might be unpredictable."

setup_mise() {  
    curl https://mise.run | sh

    if [[ "$SHELL" == "/bin/zsh" || "$SHELL" == "/usr/bin/zsh" ]]; then
        echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
        echo "Configured mise for Zsh. Please restart your shell or run: source ~/.zshrc"
    elif [[ "$SHELL" == "/bin/bash" || "$SHELL" == "/usr/bin/bash" ]]; then
        echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
        echo "Configured mise for Bash. Please restart your shell or run: source ~/.bashrc"
    else
        echo "Unknown shell. Please configure mise manually."
        exit 1
    fi
}

if ! command -v mise &> /dev/null; then
    echo "Mise is not installed. Installing now..."
    setup_mise
else
    echo "Mise is already installed - $(mise -V)"
    mise install
fi

if [[ -d ".venv" ]]; then
  echo "Activating the virtual environment..."
  source .venv/bin/activate
fi  

if [[ -f "pyproject.toml" ]]; then
  echo "pyproject.toml found. Running 'poetry install'..."
  poetry install
fi
