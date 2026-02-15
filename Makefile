# Dotfiles Management Makefile

# Ansible configuration
export ANSIBLE_CONFIG := $(PWD)/ansible/ansible.cfg

.PHONY: help doctor doctor-pyenv doctor-pipx doctor-ansible configs binaries all hammerspoon

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
	@echo "  make help           - Show this help message"

# Health checks
doctor: doctor-pyenv doctor-pipx doctor-ansible
	@echo "✓ All checks passed!"

doctor-pyenv:
	@which pyenv > /dev/null || (echo "✗ pyenv is not installed. Run: make setup-python" && exit 1)
	@echo "✓ pyenv is installed"

doctor-pipx:
	@which pipx > /dev/null || (echo "✗ pipx is not installed. Run: make setup-python" && exit 1)
	@echo "✓ pipx is installed"

# Installation stack: pyenv -> pipx -> ansible
doctor-ansible:
	@which ansible-playbook > /dev/null || (echo "✗ Ansible is not installed. Install with: pipx install --include-deps ansible" && exit 1)
	@echo "✓ Ansible is installed"

# Configure dotfiles
configs: doctor
	@echo "Configuring dotfiles..."
	ansible-playbook ansible/playbooks/configs.yml

# Install binary packages
binaries: doctor
	@echo "Installing binary packages..."
	ansible-playbook ansible/playbooks/binaries.yml

# Complete setup (binaries + configs)
all: doctor
	@echo "Running complete setup..."
	ansible-playbook ansible/playbooks/all.yml

# Setup Hammerspoon configuration
hammerspoon: doctor
	@echo "Setting up Hammerspoon configuration..."
	ansible-playbook ansible/playbooks/hammerspoon.yml
