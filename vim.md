#### Whitspaces in vim
ts : "what is the value of tab
st : "hit Tab 
sw : "hit > or <
et : "Meaning of Tab

#### List abbreviation (Refer .vimrc :create and use for commonly used text)
:ab 

#### Read man pages using VIM
	man nslookup |  ul -i | vim -

#### Vim variables
:help internal-variables
|buffer-variable|    b:	  Local to the current buffer.
|window-variable|    w:	  Local to the current window.
|tabpage-variable|   t:	  Local to the current tab page.
|global-variable|    g:	  Global.
|local-variable|     l:	  Local to a function.
|script-variable|    s:	  Local to a |:source|'ed Vim script.
|function-argument|  a:	  Function argument (only inside a function).
|vim-variable|       v:	  Global, predefined by Vim.

:echo $VIMRUNTIME "access env var
:echo &filetype  "access vim var
:echo @a  "access buffer var

extract values from options, by prefixing the option name (filetype in our case) 
with an ampersand (&) character. H
ence we will use the variable &filetype in our function.
We start with a simple version of our CheckFileType function:

function CheckFileType() 
if &filetype == ""
  filetype detect 
endif
endfunction

The Vim command filetype detect is a Vim script installed in the $VIMRUNTIME directory

### vim session and view
mksession
mkview : view inside session

### modelline usage

### Regex grouping
