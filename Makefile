# Dotfiles Management Makefile

.PHONY: help backup update all hammerspoon ansible-check

# Default target
help:
	@echo "Available commands:"
	@echo "  make backup         - Backup current ~/.zshrc and ~/.vimrc to backup/"
	@echo "  make update         - Pull latest and setup dotfiles (interactive)"
	@echo "  make all            - Backup then update"
	@echo "  make hammerspoon    - Setup Hammerspoon configuration (symbolic link)"
	@echo "  make ansible-check  - Check if Ansible is installed"
	@echo "  make help           - Show this help message"

# Backup current dotfiles
backup: ansible-check
	@echo "Backing up current dotfiles..."
	ansible-playbook ansible/playbooks/backup.yml

# Update dotfiles
update: ansible-check
	@echo "Updating dotfiles..."
	ansible-playbook ansible/playbooks/update.yml

# Backup and update
all: ansible-check
	@echo "Running full backup and update..."
	ansible-playbook ansible/playbooks/all.yml

# Setup Hammerspoon configuration
hammerspoon: ansible-check
	@echo "Setting up Hammerspoon configuration..."
	ansible-playbook ansible/playbooks/hammerspoon.yml

# Check if Ansible is installed
ansible-check:
	@which ansible-playbook > /dev/null || (echo "Ansible is not installed. Install with: brew install ansible" && exit 1)
	@echo "Ansible is installed and ready to use"
