DOTFILES_DIR := $(shell pwd)
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

.PHONY: install install-i3 install-dunst install-rofi install-rofi-themes install-vim theme

install: install-i3 install-dunst install-rofi install-rofi-themes install-vim

define symlink
	@if [ -L "$(2)" ]; then \
		echo "$(1): already symlinked, skipping"; \
	elif [ -e "$(2)" ]; then \
		mv "$(2)" "$(2).bak"; \
		echo "$(1): backed up to $(2).bak"; \
		ln -sf "$(DOTFILES_DIR)/$(1)" "$(2)"; \
		echo "$(1): symlinked"; \
	else \
		mkdir -p "$(dir $(2))"; \
		ln -sf "$(DOTFILES_DIR)/$(1)" "$(2)"; \
		echo "$(1): symlinked"; \
	fi
endef

install-i3:
	$(call symlink,.config/i3,$(XDG_CONFIG_HOME)/i3)
	@if [ ! -f "$(XDG_CONFIG_HOME)/i3/themes/current" ]; then \
		echo "arc-dark" > "$(XDG_CONFIG_HOME)/i3/themes/current"; \
		echo "i3 theme: defaulted to arc-dark"; \
	fi

install-dunst:
	$(call symlink,.config/dunst,$(XDG_CONFIG_HOME)/dunst)

install-rofi:
	$(call symlink,.config/rofi,$(XDG_CONFIG_HOME)/rofi)

install-rofi-themes:
	$(call symlink,.local/share/rofi/themes,$(XDG_DATA_HOME)/rofi/themes)

install-vim:
	$(call symlink,.vimrc,$(HOME)/.vimrc)

theme:
	@~/.config/i3/scripts/theme-switcher

