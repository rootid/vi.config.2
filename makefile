VIM_FILES = autoload colors ultisnips bundles testbundles addons
HOME_DIR = ${HOME}
CWD = ${PWD}

all: clean link

.PHONY: clean
clean: $(VIM_FILES)

link : 
	@echo "Create Symlink "
	for i in $(VIM_FILES)  ; \
	do	\
		ln -sf $(PWD)/vim.$$i $(HOME_DIR)/.vim/$$i; \
		echo $(PWD)/$$i; \
		echo $(HOME_DIR)/.vim/$$i; \
	done
	#@echo "link completed."

$(VIM_FILES) : 
	@echo "Remove Symlink $(HOME)/.vim/$@"
	@$(RM) $(HOME)/.vim/$@ 2>/dev/null
