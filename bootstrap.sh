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

# Step 3: Install uv
# Reference: https://docs.astral.sh/uv/
if ! command -v uv &> /dev/null; then
    echo "→ Installing uv..."
    brew install uv
    echo "✓ uv installed"
else
    echo "✓ uv is already installed"
fi

# Step 4: Install Ansible via uv tool
# Reference: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
if ! command -v ansible-playbook &> /dev/null; then
    echo "→ Installing Ansible..."
    uv tool install --with paramiko ansible
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
echo "  ✓ uv"
echo "  ✓ Ansible (via uv tool)"
echo ""
echo "Next steps:"
echo "  1. Restart terminal: exec zsh"
echo "  2. Setup dotfiles: make all"
echo "  3. Verify: make doctor"
echo ""
