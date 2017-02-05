#### List abbreviation (Refer .vimrc :create and use for commonly used text)
:ab 

#### Read man pages using VIM
man nslookup |  ul -i | vim -

#### Vim variables
:help internal-variables

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
