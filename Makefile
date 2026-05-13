DOTFILES_DIR := $(shell pwd)
XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: install install-i3 install-dunst install-rofi

install: install-i3 install-dunst install-rofi

define symlink-config
	@if [ -L "$(XDG_CONFIG_HOME)/$(1)" ]; then \
		echo "$(1): already symlinked, skipping"; \
	elif [ -d "$(XDG_CONFIG_HOME)/$(1)" ]; then \
		mv "$(XDG_CONFIG_HOME)/$(1)" "$(XDG_CONFIG_HOME)/$(1).bak"; \
		echo "$(1): backed up existing dir to $(XDG_CONFIG_HOME)/$(1).bak"; \
		ln -sf "$(DOTFILES_DIR)/.config/$(1)" "$(XDG_CONFIG_HOME)/$(1)"; \
		echo "$(1): symlinked"; \
	else \
		ln -sf "$(DOTFILES_DIR)/.config/$(1)" "$(XDG_CONFIG_HOME)/$(1)"; \
		echo "$(1): symlinked"; \
	fi
endef

install-i3:
	$(call symlink-config,i3)

install-dunst:
	$(call symlink-config,dunst)

install-rofi:
	$(call symlink-config,rofi)
