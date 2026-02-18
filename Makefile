# Dotfiles Management Makefile

DOTFILES_DIR     := $(shell pwd)
PLAYBOOK_DIR     := $(DOTFILES_DIR)/ansible/playbooks
ANSIBLE          := ansible-playbook
PRIVATE_MAKEFILE := $(HOME)/dotfiles-private/Makefile

export ANSIBLE_CONFIG := $(DOTFILES_DIR)/ansible/ansible.cfg

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
	@[ -f $(PRIVATE_MAKEFILE) ] && $(MAKE) --no-print-directory -f $(PRIVATE_MAKEFILE) help-private || true

# Health checks
doctor: doctor-pyenv doctor-pipx doctor-ansible
	@echo "✓ All checks passed!"

doctor-pyenv:
	@which pyenv > /dev/null || (echo "✗ pyenv is not installed. Run: ./bootstrap.sh" && exit 1)
	@echo "✓ pyenv is installed"

doctor-pipx:
	@which pipx > /dev/null || (echo "✗ pipx is not installed. Run: ./bootstrap.sh" && exit 1)
	@echo "✓ pipx is installed"

doctor-ansible:
	@which ansible-playbook > /dev/null || (echo "✗ ansible-playbook is not installed. Run: pipx install --include-deps ansible" && exit 1)
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

# Private dotfiles targets (optional, silently ignored if not present)
-include $(PRIVATE_MAKEFILE)
