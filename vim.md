#### Help vim
    * Version Check 
        :version
    * Filetype Check 
        :set ft?
    * Runtime dir Path
        :echo $VIMRUNTIME
    * Whitspaces in vim
        ts : "what is the value of tab
        st : "hit Tab 
        sw : "hit > or <
        et : "Meaning of Tab
     * List abbreviation (Refer .vimrc :create and use for commonly used text)
        :ab 
    * Keys
        C - Ctrl
        CR - Enter

    * ModelLines

#### Navigation
    * File Buffers (memory)
    * Marks (memory)
    * Keys 

#### Faster navigation

#### Edits
    * Edit keys
      Normal Mode
      Visual Mode

    * Recorded edits

#### Regex Edits

    * Regex /pattern/<operation>

    * Regex grouping

#### Storage
    * Variables (local (window,buffer),global)
    * Named buffers

#### Sessions + Views
    * vim session and view
        mks : New
        mks! : Overwrite
        mkview : view inside session

#### Diff
    * Among files
        diff file1 file2
    * Among Buffers
        windo diffthis
    * Operations
        diffget b#
        diffput b#

#### Folding
    * Marker

#### Scripts and Plugins
    * Variables
        :help internal-variables
        :echo $VIMRUNTIME "access env var
        :echo &filetype  "access vim var
        :echo @a  "access buffer var

    * Debug

#### Compilers + Quickfix list

#### Vim other usages
    * Read man pages using VIM 
        man nslookup |  ul -i | vim -

### Vim file edit model
    file -----> file.swp
     (N)  i/a    (I)
         <----- 
           w

#### Vim variables
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

<!-- 
 vim: ts=4 sw=4 tw=120 et: 
 --> 
