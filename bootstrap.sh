#!/bin/bash
set -e
set -o pipefail

echo "========================================="
echo "Dotfiles Bootstrap"
echo "========================================="
echo ""

# Step 1: Install Homebrew
# Reference: https://brew.sh/
if ! command -v brew &> /dev/null; then
    echo "→ Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✓ Homebrew is already installed"
fi

# Step 2: Update Homebrew
echo "→ Updating Homebrew..."
brew update

# Step 3: Install pyenv
# Reference: https://github.com/pyenv/pyenv?tab=readme-ov-file#macos
if ! command -v pyenv &> /dev/null; then
    echo "→ Installing pyenv..."
    brew install pyenv
    echo "✓ pyenv installed"
else
    echo "✓ pyenv is already installed"
fi

# Step 4: Configure pyenv in ~/.zshrc
# Reference: https://github.com/pyenv/pyenv?tab=readme-ov-file#zsh

# Create ~/.zshrc if it doesn't exist
if [ ! -f ~/.zshrc ]; then
    echo "→ Creating ~/.zshrc..."
    touch ~/.zshrc
fi

# Add pyenv configuration if not already present
if ! grep -q 'export PYENV_ROOT="$HOME/.pyenv"' ~/.zshrc; then
    echo "→ Configuring pyenv in ~/.zshrc..."
    echo '' >> ~/.zshrc
    echo '# pyenv configuration' >> ~/.zshrc
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc
    echo "✓ pyenv configured"
else
    echo "✓ pyenv already configured in ~/.zshrc"
fi

# Step 5: Install pipx
# Reference: https://github.com/pypa/pipx?tab=readme-ov-file#install-pipx
if ! command -v pipx &> /dev/null; then
    echo "→ Installing pipx..."
    brew install pipx
    echo "✓ pipx installed"
else
    echo "✓ pipx is already installed"
fi

# Step 6: Configure pipx PATH
echo "→ Configuring pipx PATH..."
pipx ensurepath

# Step 7: Configure pipx PATH globally (optional)
echo "→ Configuring pipx PATH globally..."
sudo pipx ensurepath --global || echo "⚠ Global pipx ensurepath skipped (optional)"

# Step 8: Install Ansible
# Reference: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pipx
if ! command -v ansible-playbook &> /dev/null; then
    echo "→ Installing Ansible..."
    pipx install --include-deps ansible
    echo "✓ Ansible installed"
else
    echo "✓ Ansible is already installed"
fi

echo ""
echo "========================================="
echo "✓ Bootstrap complete!"
echo "========================================="
echo ""
echo "Installed:"
echo "  ✓ Homebrew"
echo "  ✓ pyenv (configured in ~/.zshrc)"
echo "  ✓ pipx (PATH configured)"
echo "  ✓ Ansible"
echo ""
echo "Next steps:"
echo "  1. Restart terminal: exec zsh"
echo "  2. Setup dotfiles: make update"
echo "  3. Verify: make doctor"
echo ""
