# Files to backup
DOTFILES= \
					.aerospace.toml \
					.hushlogin \
					.zshrc \

# Declare Variables
DOTFILES_DIR=${HOME}/.dotfiles
BACKUP=${DOTFILES_DIR}/backup
BREWFILE=${DOTFILES_DIR}/Brewfile

# This is the default command that will be run when you run `make` without any arguments.
default: init stow_override backup

# Install System Dependencies
init: brew_install brew_bundle

# Backup and override stow files
# run part of the command in a subshell with () to avoid changing the current directory
stow_override:
	@make stow_test_override; \
	read -p "Are you sure you want to continue ? (y/n): " confirm; \
	[ "$$confirm" = "y" ] || { echo "Aborting..."; exit 1; }; \
	backup_dir=${BACKUP}/$(shell date +"%Y-%m-%d_%H-%M-%S")/; \
	stow --simulate --restow files 2>&1 | \
	awk '/existing target/ {for (i=1; i<=NF; i++) if ($$i == "target") print $$(i+1)}' | \
	( cd ${HOME} && while read -r file; do \
		echo "Backing up $$file to "$$backup_dir; \
		rsync -a --relative $$file $$backup_dir; \
		rm $$file; \
	done ); \
	make stow;

stow_test_override:
	@echo "The following files will be overridden by stow:";
	
	@stow --simulate --restow files 2>&1 | \
	awk '/existing target/ {for (i=1; i<=NF; i++) if ($$i == "target") print $$(i+1)}' | \
	while read -r file; do \
	  echo " $$file"; \
	done

stow:
	stow --restow --ignore ".DS_Store" --target="${HOME}" --dir="${DOTFILES_DIR}" files

backup:
	@make backup_homebrew; \
	make backup_dotfiles;

backup_homebrew:
	@brew bundle dump --force --file="${BREWFILE}" --quiet;

backup_dotfiles:
	@backup_dir=${BACKUP}/$(shell date +"%Y-%m-%d_%H-%M-%S")/; \
	echo "Backing up config files to "$$backup_dir; \
	rsync -a --include ".*" --exclude ".DS_Store" ${HOME}/.config $$backup_dir; \
	for file in ${DOTFILES}; do \
		if test -e "${HOME}/$$file"; then \
			rsync -a ${HOME}/$$file $$backup_dir || true; \
		fi; \
	done;

brew_install:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Homebrew not found. Installing..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
	fi

brew_bundle:
	@brew bundle install --file="${BREWFILE}" --no-lock --quiet; \
	brew update; \
	brew upgrade;

.PHONY: default init stow stow_test_override stow_override backup brew_install brew_bundle
