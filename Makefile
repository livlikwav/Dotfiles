# Dotfiles Management Makefile

.PHONY: help doctor doctor-pyenv doctor-pipx doctor-ansible backup update all hammerspoon

# Default target
help:
	@echo "Available commands:"
	@echo ""
	@echo "First time setup:"
	@echo "  ./bootstrap.sh      - Bootstrap (Homebrew + pyenv + pipx + Ansible)"
	@echo ""
	@echo "Regular commands:"
	@echo "  make doctor         - Run all health checks"
	@echo "  make backup         - Backup current ~/.zshrc and ~/.vimrc to backup/"
	@echo "  make update         - Pull latest and setup dotfiles (interactive)"
	@echo "  make all            - Backup then update (dotfiles only)"
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

# Backup current dotfiles
backup: doctor
	@echo "Backing up current dotfiles..."
	ansible-playbook ansible/playbooks/backup.yml

# Update dotfiles
update: doctor
	@echo "Updating dotfiles..."
	ansible-playbook ansible/playbooks/update.yml

# Backup and update
all: doctor
	@echo "Running full backup and update..."
	ansible-playbook ansible/playbooks/all.yml

# Setup Hammerspoon configuration
hammerspoon: doctor
	@echo "Setting up Hammerspoon configuration..."
	ansible-playbook ansible/playbooks/hammerspoon.yml
