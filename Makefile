# Dotfiles Management Makefile

.PHONY: help hammerspoon ansible-check

# Default target
help:
	@echo "Available commands:"
	@echo "  make hammerspoon    - Setup Hammerspoon configuration (symbolic link)"
	@echo "  make ansible-check  - Check if Ansible is installed"
	@echo "  make help          - Show this help message"

# Setup Hammerspoon configuration
hammerspoon:
	@echo "Setting up Hammerspoon configuration..."
	ansible-playbook ansible/hammerspoon.yml

# Check if Ansible is installed
ansible-check:
	@which ansible-playbook > /dev/null || (echo "Ansible is not installed. Install with: brew install ansible" && exit 1)
	@echo "Ansible is installed and ready to use"
