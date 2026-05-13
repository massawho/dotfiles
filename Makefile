DOTFILES_DIR := $(shell pwd)
XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: install install-i3

install: install-i3

install-i3:
	@if [ -L "$(XDG_CONFIG_HOME)/i3" ]; then \
		echo "i3: already symlinked, skipping"; \
	elif [ -d "$(XDG_CONFIG_HOME)/i3" ]; then \
		mv "$(XDG_CONFIG_HOME)/i3" "$(XDG_CONFIG_HOME)/i3.bak"; \
		echo "i3: backed up existing dir to $(XDG_CONFIG_HOME)/i3.bak"; \
		ln -sf "$(DOTFILES_DIR)/.config/i3" "$(XDG_CONFIG_HOME)/i3"; \
		echo "i3: symlinked"; \
	else \
		ln -sf "$(DOTFILES_DIR)/.config/i3" "$(XDG_CONFIG_HOME)/i3"; \
		echo "i3: symlinked"; \
	fi
