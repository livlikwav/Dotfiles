# Dotfiles Management Makefile

DOTFILES_DIR     := $(shell pwd)
PLAYBOOK_DIR     := $(DOTFILES_DIR)/ansible/playbooks
ANSIBLE          := ansible-playbook

export ANSIBLE_CONFIG := $(DOTFILES_DIR)/ansible/ansible.cfg

.PHONY: help doctor doctor-uv doctor-ansible configs binaries all hammerspoon nvim

# Default target
help:
	@echo "Available commands:"
	@echo ""
	@echo "First time setup:"
	@echo "  ./bootstrap.sh      - Bootstrap (Homebrew + pyenv + pipx + Ansible)"
	@echo ""
	@echo "Regular commands:"
	@echo "  make doctor         - Run all health checks"
	@echo "  make configs        - Configure dotfiles (zsh, vim, hammerspoon)"
	@echo "  make binaries       - Install binary packages from Brewfile"
	@echo "  make all            - Install binaries + configure (complete setup)"
	@echo "  make hammerspoon    - Setup Hammerspoon configuration (symbolic link)"
	@echo "  make nvim           - Setup neovim configuration (symbolic link)"
	@echo "  make help           - Show this help message"
	@echo ""
	@echo "Note: 'make configs' / 'make all' also clones and runs ~/Dotfiles-private"
	@echo "      (see ~/Dotfiles-private/Makefile for its standalone commands)"

# Health checks
doctor: doctor-uv doctor-ansible
	@echo "✓ All checks passed!"

doctor-uv:
	@which uv > /dev/null || (echo "✗ uv is not installed. Run: ./bootstrap.sh" && exit 1)
	@echo "✓ uv is installed"

doctor-ansible:
	@which ansible-playbook > /dev/null || (echo "✗ ansible-playbook is not installed. Run: uv tool install ansible" && exit 1)
	@echo "✓ ansible-playbook is installed"

# Configure dotfiles
configs: doctor
	@echo "Configuring dotfiles..."
	$(ANSIBLE) $(PLAYBOOK_DIR)/configs.yml

# Install binary packages
binaries: doctor
	@echo "Installing binary packages..."
	$(ANSIBLE) $(PLAYBOOK_DIR)/binaries.yml

# Complete setup (binaries + configs)
all: doctor
	@echo "Running complete setup..."
	$(ANSIBLE) $(PLAYBOOK_DIR)/all.yml

# Setup Hammerspoon configuration
hammerspoon: doctor
	@echo "Setting up Hammerspoon configuration..."
	$(ANSIBLE) $(PLAYBOOK_DIR)/hammerspoon.yml

# Setup neovim configuration
nvim: doctor
	@echo "Setting up neovim configuration..."
	$(ANSIBLE) $(PLAYBOOK_DIR)/nvim.yml
