# git-sisters-update.ps1 from within http://github.com/wilsonmar/git-utilities.
# by Wilson Mar (wilsonmar@gmail.com, @wilsonmar)

# This script was created for experiementing and learning Git with GitHub.
# Git commands in this script are meant as examples for manual entry
# explained during my live "Git and GitHub" tutorials and
# explained at https://wilsonmar.github.io/git-commands-and-statuses/).
# Most of the regularly used Git commands are covered here.

# This script clones and edits a sample repo with known history.

# This script is designed to be "idempotent" in that repeat runs
# result in the same condition whether it's run the first or subsequent times.
# This is achieved by beginning the run by deleting what was created
# by the previous run.

# PRE-REQUSITES: Before running this on a Mac, install PowerShell for Mac.
   # TODO: Add handling of script call attribute containing REPONAME and GITHUB_USER:
  $GITHUB_USERID="wilson-jetbloom" # <-- replace with your own

# Sample call in MacOS running PowerShell for Mac:
#     chmod +x git-sisters-update.ps1
#     ./git-sisters-update.ps1
# results in "Add " as branch name. Alternately, run script with your own branch:
#     ./git-sisters-update.ps1 "Add year 1979"

# Last tested on MacOS 10.12 (Sierra) 2015-11-29
# http://skimfeed.com/blog/windows-command-prompt-ls-equivalent-dir/


# PS TRICK: Functions must be defined at the top of the script.
function sisters_new_photo-info
{
    # sisters_new_photo-info  1979  "Bloomfield, Connecticut"
    $PIC_YEAR = $args[0] # 1979 or other year.
    $FILE_CONTEXT = "photo-info.md" # file name
    $PIC_CITY = $args[1] # City

    Remove-Item $FILE_CONTEXT -recurse -force # CAUTION: deleting file!
        # -force deletion of hidden and read only items.
    New-Item $FILE_CONTEXT >$null
    $NL = "`n" # New Line $s, $t -join ", "
    $OUT_STRING  = "# Photo Information" +$NL
    $OUT_STRING += $NL
    $OUT_STRING += "**Year:** " +$PIC_YEAR +$NL # **Year:** 1978
    $OUT_STRING += $NL
    $OUT_STRING += "**City: ** " +$PIC_CITY +$NL # **City: ** Harwich Port, Massachusetts
    $OUT_STRING | Set-Content $FILE_CONTEXT

        echo "******** cat $FILE_CONTEXT for $PIC_YEAR : AFTER changes :"
    cat $FILE_CONTEXT
}

function sisters_new_meta_file
{
    # TODO:
    $PERSON_NAME = $args[0]
    $FILE_CONTEXT = $args[0].ToLower() + ".md" # file name

    $SMILING = $args[1] # smiling true or false
    $CLOTHING = $args[2]

    Remove-Item $FILE_CONTEXT -recurse -force # CAUTION: deleting file!
        # -force deletion of hidden and read only items.
    New-Item $FILE_CONTEXT >$null

    $NL = "`n" # New Line $s, $t -join ", "
    $OUT_STRING  = "# $PERSON_NAME" +$NL
    $OUT_STRING += $NL
    # PROTIP: Double grave-accent(`) to use back-tick as regular text:
    $OUT_STRING += "**Smiling:** ``$SMILING``" +$NL
    $OUT_STRING += $NL
    $OUT_STRING += "**Outfit:** $CLOTHING"
    $OUT_STRING | Set-Content $FILE_CONTEXT

        echo "******** cat $FILE_CONTEXT : AFTER changes :"
    cat $FILE_CONTEXT
}

function sisters_replace_meta_file
{
    $PERSON_NAME  = $args[0]
    $FILE_CONTEXT = $args[0].ToLower() + ".md" # file name
        echo "******** cat $FILE_CONTEXT : BEFORE change :"
    cat $FILE_CONTEXT

        echo "******** processing $FILE_CONTEXT :"
    #$SMILING = $args[1] # smiling true or false
    #$CLOTHING = $args[2]

               # Get-Content info: https://technet.microsoft.com/en-us/library/ee176843.aspx
    $WORK_TEXT = Get-Content $FILE_CONTEXT
    #cat $WORK_TEXT

    # About regex in PowerShell: https://www.youtube.com/watch?v=K3JKmWmbbGM
    if ($args[1] -eq "true"){
      $WORK_TEXT -replace '(\*\*Smiling:\*\* `true`)' ,'\*\*Smiling:\*\* `false`'
    }else{ # -eq "false"
      $WORK_TEXT -replace '(\*\*Smiling:\*\* `false`)','\*\*Smiling:\*\* `true`'
    }

    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
    [System.IO.File]::WriteAllLines($MyPath, $WORK_TEXT, $Utf8NoBomEncoding)
    # $WORK_TEXT | Set-Content $FILE_CONTEXT
    # Set-Content info: https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.management/Set-Content?f=255&MSPPError=-2147217396

    # PROTIP: Use https://regex101.com/ using Flavor: PY (python) to verify:
    # Put slashes in front of special characters used as regular text:

        echo "******** cat $FILE_CONTEXT : AFTER changes :"
    cat $FILE_CONTEXT
}

function du-hs {
    # Size of bytes in folder: instead of Linux command): du -hs ${REPONAME}
    # (7 files in 1475 bytes) https://blogs.technet.microsoft.com/heyscriptingguy/2012/05/25/getting-directory-sizes-in-powershell/
    Get-ChildItem $REPONAME | Measure-Object -Sum Length | Select-Object Count, Sum
}

#################################

# Create blank lines in the log to differentiate different runs:
        # Clear-Host  # clear in PowerShell see https://kgk.gr/2011/10/16/powershell-clrscr/
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
   # Make the beginning of run easy to find:
        echo "**********************************************************"
$NOW = Get-Date -Format "yyyy-MM-ddTHH:mmzzz"
        echo "******** NOW=$NOW $PSUICULTURE PID=$PID :"
             # $PSUICULTURE & $PID are built-in variables.
    $PSHOME #$psversiontable
        echo "******** IsWindows=$IsWindows IsOSX=$IsOSX IsLinux=$IsLinux"
    #[System.Environment]::OSVersion.Version
        echo "******** PSSCRIPTROOT= $PSSCRIPTROOT"
    git --version

# exit #1

  $REPONAME='sisters'
  $UPSTREAM="https://github.com/hotwilson/sisters" # a repo prepared for the class.
  $CURRENT_COMMIT=""

        echo "******** Delete $REPONAME remaining from previous run (for idempotent script):"
$FileExists = Test-Path $REPONAME
if ($FileExists -eq $True ){
   # See https://technet.microsoft.com/en-ca/library/hh849765.aspx?f=255&MSPPError=-2147217396
   Remove-Item -path ${REPONAME} -Recurse -Force # instead of rm -rf ${REPONAME}
}
        echo "******** Exit #2."
#  exit #2

# New-item ${REPONAME} -ItemType "directory" >$null  # instead of mkdir ${REPONAME}
   # >$null suporesses several lines being printing out by PS to confirm.

    $GITHUB_REPO="https://github.com/"+ $GITHUB_USERID +"/"+ $REPONAME
        echo "******** Before running this, fork from $UPSTREAM "
        echo "******** git clone $GITHUB_REPO "
         # Notice the string concatenation format:
git clone "$($GITHUB_REPO).git" # $REPONAME # --depth=1

        echo "******** git tag -l cloned  # lightweight tag for private temp use :"
git tag -l cloned
        # Note no spaces and thus no quotes.
        echo "******** git tag (list) :"
git tag
        echo "******** git log :"
    git l -3

    echo "******** Exit #3."
#  exit #3

        echo "******** Ensure $REPONAME folder is specified in .gitignore file:"
    # & ((Split-Path $MyInvocation.InvocationName) + "\my_ps_functions.ps1")
    if (Test-Path ".gitignore"){
            echo "******** .gitignore file found within ${REPONAME} folder :"
       Select-String -Pattern "$REPONAME" -Path ".gitignore" > $null # -CaseSensitive
       #get-content myfile.txt -ReadCount 1000 | foreach { $_ -match "my_string" }
        echo "******** ${REPONAME} FOUND within .gitignore file."
    } Else {
       echo "${REPONAME}">>.gitignore   # save text at bottom of file.
        #  sed 's/fields/fields\nNew Inserted Line/' .gitignore
       echo "******** ${REPONAME} added to bottom of .gitignore file."
    }

    echo "******** Exit #4."
#  exit #4


cd ${REPONAME}
$CurrentDir = $(get-location).Path;
# This outputs the parent folder, not the current folder:
#$CURRENTDIR = (Get-Item -Path ".\" -Verbose).FullName   # Get-Location cmdlet
#$CURRENTDIR = $PSScriptRoot    # PowerShell specific
#        echo "CURRENTDIR=$CURRENTDIR"
        echo "******** Now in $REPONAME folder! - cd .. before re-run!"
        echo $CURRENTDIR

# exit #5


        echo "******** Run PowerShell file for Git configurations at the repo level:"
        # PS TRICK: Get parent folder path using the $MyInvocation built-in PS variable:
        # See http://stackoverflow.com/questions/7377981/how-do-i-call-another-powershell-script-with-a-relative-path
        $ScriptPath = Split-Path -Parent $MyInvocation.InvocationName
        $UtilPath  = Join-Path -Path $ScriptPath -ChildPath ..\
        #Write-Host "Path:" $UtilPath
        # NOTE: PowerShell accepts both forward and backward slashes:
    & "$UtilPath/git-client-config.ps1"
        # Alternately, use & to run scripts in same scope:
        # & "../git_client-config.ps1 global" #
        # Alternately, use . to run scripts in child scope that will be thrown away:
        # . "../git_client-config.ps1 global" #
        #echo "******** Present Working Directory :"
    #pwd

    echo "******** Exit #6."
#  exit #6

         Write-Host "******** git remote add upstream $UPSTREAM :"
git remote add upstream ${UPSTREAM}
         Write-Host "******** git remote -v :"
    git remote -v
         Write-Host "******** git remote show origin :"
    git remote show origin

         echo "******** cat .git/HEAD to show internal current branch HEAD :"
    # The contents of HEAD is stored in this file:
    cat .git/HEAD

         echo "******** git branch -avv at master:"
git branch -avv  # shows tracking branches
                 # In Merge lesson, change hotwilson GitHub at this point and git merge

         echo "******** Exit #7."
# exit #7

         echo "******** git l = git log of commits in repo:"
         # add -10 to list 10 lines using l for log alias:
    git l
         echo "******** tree of folders in working area:"
    # PS TRICK: Different commands to list folders with properties:
    if( "$IsWindows" -eq $True ) {
        dir
    }else{ # Mac / Linux:
        ls # -al
    }
    #tree
         echo "******** git reflog (showing only what occurred locally):"
    git reflog

         # These above commands cover the dimensions: branch, commits, working directory, staging, lines, hunks.

         echo "******** git status at initial clone:"
    git status

    echo "******** Exit #8."
#  exit #8

         echo "******** cat ${REPONAME}/bebe.md at HEAD:"
    cat bebe.md

         echo "******** git blame bebe.md : "
    git blame bebe.md
         # NOTE:
         echo "******** git l = git log of commits in repo:"
         # add -10 to list 10 lines using l for log alias:
    git l -10
         # Notice the title "BeBe" and blank lines in the file are from the initial commit.
         # Two lines were changed in the latest commit.

         echo "******** Exit #9."
#  exit #9

#         echo "******** git show --oneline --abbrev-commit - press q to quit:"
#    git show --oneline --abbrev-commit

    git diff HEAD..HEAD^

    echo "******** Exit #10."
#  exit #10

#        echo "******** Begin trace :"
#    # Do not set trace on:
#    set -x  # xtrace command         echo on (with ++ prefix). http://www.faqs.org/docs/abs/HTML/options.html

        echo "******** git checkout master branch:"
git checkout master

    # PS TRICK: Check for no arguments specified with invocation command:
    if( $($args.Count) -eq 0 ) {
       $CURRENT_BRANCH="feature1"
    }else{
       $CURRENT_BRANCH=$args[0]
    }
        echo "******** git checkout new branch ""$CURRENT_BRANCH"" from master branch :"
git checkout -b $CURRENT_BRANCH
    git branch -avv
        # PS TRICK: Double-quotes to display words in quotes:
        echo "******** git reflog at ""$CURRENT_BRANCH"" :"
    git reflog

    echo "******** Exit #11."
#  exit #11

    $CURRENT_YEAR = "1979"
        echo "******** Make changes to $CURRENT_YEAR files and stage it at $CURRENT_COMMIT :"
sisters_new_photo-info  $CURRENT_YEAR  "Hartford, Connecticut"

#sisters_new_meta_file  BeBe     false  "White buttoned shirt"
    # Notice the person name is upper/lower case:

    echo "******** Exit #12."
#  exit #12

        echo "******** git checkout ""@{10 minutes ago}"" :"
git checkout "@{10 minutes ago}"

sisters_new_meta_file  Bebe     false  "White buttoned shirt"
    # Notice the person name is unchanged from previous commits:

    #    echo "******** git add -p (hunks interactive) :"
    #git add -p  # GUI (requires manual response)

    echo "******** Exit #13."
  exit #13

sisters_new_meta_file  Heather  true   "Plaid shirt"
sisters_new_meta_file  Laurie   false  "Cable-knit sweater"
sisters_new_meta_file  Mimi     false  "French sailor shirt"

echo "******** Exit #14."
#  exit #14

        echo "******** git stash :"
git stash
        # Response:
        # Saved working directory and index state WIP on feature1: ea2db2c Snapshot for 1978
        # HEAD is now at ea2db2c Snapshot for 1978
        echo "******** git stash list :"
git stash list
        # Response: stash@{0}: WIP on feature1: ea2db2c Snapshot for 1978

        echo "******** git status (after git stash) :"
    git status

    echo "******** Exit #15."
#  exit #15

    # Do something else

        echo "******** git stash pop :"
git stash pop
        echo "******** git status : before git add :"
    git status

    echo "******** Exit #16."
#  exit #16

        echo "******** git add . :"
git add .  # photo-info.md  bebe.md  heather.md  laurie.md  mimi.md
        echo "******** git status : after git add "
    git status
        echo "******** git commit of $CURRENT_YEAR (new commit SHA) :"
git commit -m"Snapshot for $CURRENT_YEAR"
        echo "******** git status : after git add "
    git status
        echo "******** git diff (files committed and will be pushed) :"
    git diff --stat HEAD origin/$CURRENT_BRANCH
    #git cherry -v
    #git diff origin/master..master
    #git diff --stat HEAD --cached origin/$CURRENT_BRANCH
    #    echo "******** git diff (contents of what has been committed and will be pushed) :"
    #git diff --stat --patch origin master
    #git diff origin/master HEAD
        echo "******** git reflog at ""$CURRENT_BRANCH"" :"
    git reflog
        echo "******** git git diff HEAD^ :"
    git diff HEAD^
        echo "******** git l = git log of commits in repo:"
    git l

    echo "******** Exit #17."
exit #17 --- major checkpoint here.

         # Export an entire branch, complete with history, to the specified file:
         # git bundle create <file> <branch-name>

         # Re-create a project from a bundled repository and checkout <branch‑name>:
         # git clone repo.bundle <repo-dir> -b <branch-name>

    # echo "******** git archive master :"
    if( "$make_archive" -eq $True ) {
        if( "$IsWindows" -eq $True ) {
            git archive $CURRENT_BRANCH --format=zip --output=$REPONAME_$CURRENT_BRANCH_$REPONAME.zip
        }else{ # Mac / Linux:
            git archive $CURRENT_BRANCH --format=tar --output=$REPONAME_$CURRENT_BRANCH_$REPONAME.tar
        }
    }
# list files archived.

echo "******** Exit #18."
 exit #18


    #git push --dry-run


    echo "******** Exit #20."
 exit #19
 #exit #20 reserved


    # TODO: Extract $CURRENT_COMMIT from capturing git command.

    $CURRENT_COMMIT="c4b84db"
        echo "******** git checkout $CURRENT_COMMIT : (parent branch) :"
git checkout $CURRENT_COMMIT
        echo "******** cat .git/HEAD :"
    cat .git/HEAD  # contains a commit SHA rather than HEAD
        echo "******** git checkout -b branch1 :"
    git checkout -b branch1  # Switched to a new branch 'branch1'

         echo "******** cat bebe.md at $CURRENT_COMMIT :"
    cat bebe.md
        echo "******** git log at $CURRENT_BRANCH :"
    git commit

    echo "******** Exit #21."
  exit #21

    $CURRENT_COMMIT="a874ef4"
        echo "******** git reset --soft $CURRENT_COMMIT (to remove it):"
git reset --soft $CURRENT_COMMIT
        echo "******** git fsck after $CURRENT_COMMIT :"
    git fsck
        echo "******** git reflog at $CURRENT_BRANCH :"
    git reflog

    echo "******** Exit #22."
   exit #22

        echo "******** Make changes to files and stage it at $CURRENT_COMMIT :"
echo "change 1">>bebe.md
git add bebe.md
        echo "******** git reset HEAD at $CURRENT_COMMIT :"
git reset HEAD
        echo "******** git fsck after $CURRENT_COMMIT :"
    git fsck

    echo "******** Exit #23."
   exit #23

    $CURRENT_COMMIT="82e957c"
        echo "******** git reset --hard a874ef2 :"
git reset --hard $CURRENT_COMMIT
        echo "******** git fsck after $CURRENT_COMMIT :"
    git fsck


        echo "******** Exit #24. $NOW ends."
   exit #24

##############################

# END OF FILE
