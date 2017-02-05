.PHONY: clean vim_link dot_link

VIM_FILES = autoload colors ultisnips bundles testbundles addons

DOT_FILES = ackrc vimrc gitconfig 'tmux.conf'

HOME_DIR = ${HOME}
CWD = ${PWD}

all: clean vim_link dot_link

hello:
	@echo "Running pre-commit"

clean: $(VIM_FILES) $(DOT_FILES)

clean_dot: $(DOT_FILES)

vim_link : 
	@echo "Create Symlink "
	for i in $(VIM_FILES)  ; \
	do	\
		ln -sf $(PWD)/vim.$$i $(HOME_DIR)/.vim/$$i; \
		echo $(PWD)/$$i; \
		echo $(HOME_DIR)/.vim/$$i; \
	done
	@echo "link completed."

dot_link: 
	@echo "Creating dot Symlink "
	for i in $(DOT_FILES)  ; \
	do	\
		echo $(PWD)/$$i; \
		ln -sf $(PWD)/dot_conf/$$i.conf $(HOME_DIR)/.$$i; \
	done
	@echo "link completed."

$(VIM_FILES) : 
	@echo "Remove Symlink $(HOME)/.vim/$@"
	@$(RM) $(HOME)/.vim/$@ 2>/dev/null

$(DOT_FILES) : 
	@echo "Remove Symlink $(HOME)/.$@"
	@$(RM) $(HOME)/.$@ 2>/dev/null

# vim: noexpandtab
