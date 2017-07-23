#!/usr/bin/env bash

# git-sample-repo-create.sh from within http://github.com/wilsonmar/git-utilities.
# by Wilson Mar (wilsonmar@gmail.com, @wilsonmar)

# This script was created for experiementing and learning Git.
# Git commands in this script are meant as examples for manual entry
# explained during my live "Git and GitHub" tutorials and
# explained at https://wilsonmar.github.io/git-commands-and-statuses/).
# Most of the regularly used Git commands are covered here.

# This script creates and populates a sample repo which is then
# uploaded to a new repo created using GitHub API calls

# This script is designed to be "idempotent" in that repeat runs
# begin by deleting what was created: the local repo and repo in GitHub.

# Sample call in MacOS Terminal shell window:
# chmod +x git-sample-repo-create.sh
# ./git-sample-repo-create.sh

# Last tested on MacOS 10.11 (El Capitan) 2015-09-15
# TODO: Create a PowerShell script that works on Windows:
# git-sample-repo-create.ps1

# Create blank lines in the log to differentiate different runs:
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
  TZ=":UTC" date +%z
  NOW=$(date +%Y-%m-%d:%H:%M:%S%z)
           # 2016-09-16T05:26-06:00 vs UTC

    # Make the beginning of run easy to find:
        echo "**********************************************************"
        echo "******** $NOW Versions :"
# After "brew install git" on Mac:
git --version

# exit #1

        echo "******** STEP .secret Attribution & Config (not --global):"
# Invoke file defined manually containing definition of GITHUB_PASSWORD:
source ~/.secrets  # but don't         echo "GITHUB_PASSWORD=$GITHUB_PASSWORD"

# See https://git-scm.com/docs/pretty-formats :
git config user.email $GITHUB_USER_EMAIL # "wilsonmar@gmail.com"
git config user.name  $GITHUB_USER_NAME # "Wilson Mar" # Username (not email) in GitHub.com cloud.
git config user.user  $GITHUB_USER # "wilsonmar" # Username (not email) in GitHub.com cloud.
#GITHUB_USER=$(git config github.email)  # Username (not email) in GitHub.com cloud.
        echo "GITHUB_USER_EMAIL= $GITHUB_USER_EMAIL"
#         echo $GIT_AUTHOR_EMAIL
#         echo $GIT_COMMITTER_EMAIL

# After gpg is installed and # gpg --gen-key:
git config --global user.signingkey $GITHUB_SIGNING_KEY
# gpg --list-keys



  REPONAME='git-sample-repo'
  GITHUB_USER="wilsonmar"
  DESCRIPTION="Automated Git repo from run using $REPONAME in https://github.com/wilsonmar/git-utilities."

        echo "******** GITHUB_USER=$GITHUB_USER "

# exit #2

        echo "******** STEP Delete \"$REPONAME\" remnant from previous run:"
#   set -x  # xtrace command         echo on (with ++ prefix). http://www.faqs.org/docs/abs/HTML/options.html
    # Remove folder if exists (no symbolic links are used here):
if [ -d ${REPONAME} ]; then
   rm -rf ${REPONAME}
fi

# Remove folder because files are built (not cloned in):
mkdir ${REPONAME}
cd ${REPONAME}

  CURRENTDIR=${PWD##*/}

        echo "CURRENTDIR=$CURRENTDIR"

# exit #3


        echo "******** Ensure \"$REPONAME\" folder is in .gitignore file:"
   # -F for fixed-strings, -x to match whole line, -q for quiet (not show text sought)
if grep -Fxq "${REPONAME}" .gitignore ; then
   echo "FOUND within .gitignore file."
else
   echo ${REPONAME}>>.gitignore
    #  sed 's/fields/fields\nNew Inserted Line/' .gitignore
   echo "Added to bottom of .gitignore file."
fi

# exit #4


        echo "******** STEP Init repo :"
# init without --bare so we get a working directory:
git init
# return the .git path of the current project::
git rev-parse --git-dir
ls .git/

        echo "******** STEP Make develop the default branch instead of master :"
# The contents of HEAD is stored in this file:
cat .git/HEAD

# Change from default "ref: refs/heads/master" :
    # See http://www.kernel.org/pub/software/scm/git/docs/git-symbolic-ref.html
DEFAULT_BRANCH="develop"
git symbolic-ref HEAD refs/heads/$DEFAULT_BRANCH
cat .git/HEAD
git branch -avv
#         echo $DEFAULT_BRANCH

# exit #5

         echo "******** Configure git aliases : "

# Verify settings:
git config core.filemode false
git config core.autocrlf input
git config core.safecrlf true

# On Unix systems, ignore ^M symbols created by Windows:
# git config core.whitespace cr-at-eol

# Change default commit message editor program to Sublime Text (instead of vi):
   git config core.editor "~/Sublime\ Text\ 3/sublime_text -w"

# Allow all Git commands to use colored output, if possible:
git config color.ui auto

# See https://git-scm.com/docs/pretty-formats : Add "| %G?" for signing
# In Windows, double quotes are needed:
git config alias.l  "log --pretty='%Cred%h%Creset %C(yellow)%d%Creset | %Cblue%s%Creset' --graph"

git config alias.s  "status -s"
#it config alias.w "show -s --quiet --pretty=format:'%Cred%h%Creset | %Cblue%s%Creset | (%cr) %Cgreen<%ae>%Creset'"
git config alias.w  "show -s --quiet --pretty=format:'%Cred%h%Creset | %Cblue%s%Creset'"
git config alias.ca "commit -a --amend -C HEAD" # (with no message)

# Have git diff use mnemonic prefixes (index, work tree, commit, object) instead of standard a and b notation:
git config diff.mnemonicprefix true

# Reuse recorded resolution of conflicted merges - https://git-scm.com/docs/git-rerere
git config rerere.enabled false

# git config --list   # Dump config file

         echo "******** git count-objects -v : baseline "
# Get the size of what was transmitted on the current repo folder:
git count-objects -v

         echo "******** git remote show origin : "
git remote show origin

# exit #6


        echo "******** STEP commit (initial) README :"
        echo -e "Hello" >>README.md
git add .
git commit -m "README.md"
git l -1

 exit #11

        echo "******** STEP amend commit README : "
# ammend last commit with all uncommitted and un-staged changes:
# See http://unix.stackexchange.com/questions/219268/how-to-add-new-lines-when-using-        echo
        echo -e "color">>README.md
git ca  # use this alias instead of git commit -a --amend -C HEAD
git l -1

        echo "******** STEP amend commit 2 : "
# ammend last commit with all uncommitted and un-staged changes:
        echo -e "still more\r\n">>README.md
git ca  # alias for git commit -a --amend -C HEAD
git l -1

        echo "******** STEP commit .DS_Store in .gitignore :"
        echo ".DS_Store">>.gitignore
git add .
git commit -m "Add .gitignore"
git l -1

        echo "******** STEP commit --amend .secrets in .gitignore :"
        echo "secrets">>.gitignore
        echo ".secrets">>.gitignore
git add .
git ca  # use this alias instead of git commit -a --amend -C HEAD
git l -1

git reflog
ls -al

# cat README.md

#         echo "******** rebase squash : "

        echo "******** STEP lightweight tag :"
git tag "v1"  # lightweight tag
git l

 exit #15


        echo "******** STEP checkout HEAD to create feature1 branch : --------------------------"
git checkout HEAD -b feature1
# git branch
ls .git/refs/heads/
git l -1

        echo "******** STEP commit c - LICENSE.md : "
        echo -e "MIT\r\n">>LICENSE.md
git add .
git commit -m "Add c"
git l -1
ls -al

        echo "******** STEP commit: d"
        echo -e "free!">>LICENSE.md
        echo "d">>file-d.txt
git add .
git commit -m "Add d in feature1"
git l -1
ls -al

#        echo "******** STEP Merge feature1 :"
# Instead of git checkout $DEFAULT_BRANCH :
#   git checkout @{-1}  # checkout previous branch (develop, master)

        echo "******** STEP Merge feature1 :"
# Alternately, use git-m.sh to merge and delete in one step.
# git merge --no-ff (no fast forward) for "true merge":
#git merge feature1 --no-ff --no-commit  # to see what may happen
git merge feature1 -m "merge feature1" --no-ff  # --verify-signatures
# resolve conflicts here?
git add .
# git commit -m "commit merge feature1"
git branch
git l -1

        echo "******** $NOW Remove merged branch ref :"
git branch -D feature1
git branch

        echo "******** $NOW What's dangling? "
git fsck --dangling --no-progress
git l -1

        echo "******** STEP commit: e"
        echo "e money">>file-e.txt
git add .
git commit -m "Add e"
git l -1

        echo "******** STEP commit: f"
        echo "f money">>file-f.txt
ls -al
git add .
git commit -m "Add f"
git l -1

        echo "******** STEP heavyeight tag (a commit) :"
#  git tag -a v0.0.1 -m"v1 unsigned"
   git tag -a v0.0.1 -m"v1 signed" -s  # signed "heavyweight" tag
   # For numbering, see http://semver.org/
#         echo "******** STEP tag verify :"
# git tag -v v1  # calls verify-tag.
git verify-tag v0.0.1

#         echo "******** STEP tag show :"
# git show v1  # Press q to exit scroll.

 exit #21


        echo "Copy this and paste to a text edit for reference: --------------"
git l
        echo "******** show HEAD : ---------------------------------------"
git w HEAD
        echo "******** show HEAD~1 :"
git w HEAD~1
        echo "******** show HEAD~2 :"
git w HEAD~2
        echo "******** show HEAD~3 :"
git w HEAD~3
        echo "******** show HEAD~4 :"
git w HEAD~4

        echo "******** show HEAD^ :"
git w HEAD^
        echo "******** show HEAD^^ :"
git w HEAD^^
        echo "******** show HEAD^^^ :"
git w HEAD^^^
        echo "******** show HEAD^^^^ :"
git w HEAD^^^^

        echo "******** show HEAD^1 :"
git w HEAD^1
        echo "******** show HEAD^2 :"
git w HEAD^2

        echo "******** show HEAD~1^1 :"
git w HEAD~1^1
        echo "******** show HEAD~2^1 :"
git w HEAD~2^1
        echo "******** show HEAD~3^1 :"
git w HEAD~3^1

        echo "******** show HEAD~1^2 :"
git w HEAD~1^2

        echo "******** show HEAD~2^2 :"
git w HEAD~2^2
        echo "******** show HEAD~2^3 :"
git w HEAD~2^3
ls -al

  exit #31

        echo "******** Reflog: ---------------------------------------"
git reflog
        echo "******** show HEAD@{5} :"
git w HEAD@{5}


        echo "******** STEP Create archive file, excluding .git directory :"
   TZ=":UTC" date +%z
   NOW=$(date +%Y-%m-%d:%H:%M:%S%z)
           # 2016-09-16T05:26-06:00 vs UTC
   FILENAME=$(        echo ${REPONAME}_${NOW}.zip)

        echo "FILENAME=$FILENAME"

#        echo "******** STEP Creating a zip file :"
   # Commented out to avoid creating a file from each run:
# git archive --format zip --output ../$FILENAME  feature1
   # ls -l ../$FILENAME


        echo "******** STEP checkout c :"
ls -al
git show HEAD@{5}
git checkout HEAD@{5}
ls -al

        echo "******** Go back to HEAD --hard :"
git reset --hard HEAD
# git checkout HEAD
ls -al


        echo "******** Garbage Collect (gc) what Git can't reach :"
git gc
git reflog
ls -al
        echo "******** Compare against previous reflog."


# See https://gist.github.com/caspyin/2288960 about GitHub API
# From https://gist.github.com/robwierzbowski/5430952 on Windows
# From https://gist.github.com/jerrykrinock/6618003 on Mac

        echo "****** GITHUB_USER=$GITHUB_USER, CURRENTDIR=$CURRENTDIR, REPONAME=$REPONAME"
        echo "****** DESCRIPTION=$DESCRIPTION"
   # Bash command to load contents of file into env. variable:
   export RSA_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)
   # TODO: Windows version.
   #         echo "RSA_PUBLIC_KEY=$RSA_PUBLIC_KEY"

  exit #41

# The following use jq installed locally.

# Since no need to create another token if one already exists:
if [ "$GITHUB_TOKEN" = "" ]; then  # Not run before
	        echo "******** Creating Auth GITHUB_TOKEN to delete repo later : "
    GITHUB_TOKEN=$(curl -v -u "$GITHUB_USER:$GITHUB_PASSWORD" -X POST https://api.github.com/authorizations -d "{\"scopes\":[\"delete_repo\"], \"note\":\"token with delete repo scope\"}" | jq ".token")
       # Do not         echo GITHUB_TOKEN=$GITHUB_TOKEN # secret
       # API Token (32 character long string) is unique among all GitHub users.
       # Response: X-OAuth-Scopes: user, public_repo, repo, gist, delete_repo scope.
       # See https://developer.github.com/v3/oauth_authorizations/#create-a-new-authorization

    # WORKFLOW: Manually see API Tokens on GitHub | Account Settings | Administrative Information
else
	        echo "******** Verifying Auth GITHUB_TOKEN to delete repo later : "
#    FIX: Commented out due to syntax error near unexpected token `|'
    GITHUB_AVAIL=$(curl -v -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com | jq ".authorizations_url")
            echo "******** authorizations_url=$GITHUB_AVAIL"
       # https://api.github.com/authorizations"
fi

####
            echo "******** Checking GITHUB repo exists (_AVAIL) from prior run: "
    GITHUB_AVAIL=$(curl -X GET https://api.github.com/repos/${GITHUB_USER}/${REPONAME} | jq ".full_name")
            echo "GITHUB_AVAIL=$GITHUB_AVAIL (null if not exist)"
       # Expecting "full_name": "wilsonmar/git-sample-repo",
       # TODO: Fix return of null.

if [ "$GITHUB_AVAIL" = "${GITHUB_USER}/${REPONAME}" ]; then  # Not run before
	        echo "******** Deleting GITHUB_REPO created earlier : "
        # TODO: Delete repo in GitHub.com Settings if it already exists:
      # Based on https://gist.github.com/JadedEvan/5639254
      # See http://stackoverflow.com/questions/19319516/how-to-delete-a-github-repo-using-the-api
    GITHUB_AVAIL=$(curl -X DELETE -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/${GITHUB_USER}/${REPONAME} | jq ".full_name")
      # Response is 204 No Content per https://developer.github.com/v3/repos/#delete-a-repository
            echo "GITHUB_AVAIL=$GITHUB_AVAIL deleted."
else
	        echo "******** No GITHUB repo known to delete. "
fi

#### Create repo in GitHub:
	        echo "******** Creating GITHUB repo. "
    GITHUB_AVAIL=$(curl -u $GITHUB_USER:$GITHUB_PASSWORD https://api.github.com/user/repos -d "{\"name\": \"${REPONAME:-${CURRENTDIR}}\", \"description\": \"${DESCRIPTION}\", \"private\": false, \"has_issues\": false, \"has_downloads\": true, \"has_wiki\": false}" | jq ".full_name")
            echo "GITHUB_AVAIL=$GITHUB_AVAIL created."
       GITHUB_PASSWORD=""  # No longer needed.

    # Set the freshly created repo to the origin and push
    git remote add origin "https://github.com/$GITHUB_USER/$REPONAME.git"
    git remote -v
    git push --set-upstream origin develop
    git remote show origin
#    git remote set-url origin git@github.com:${GITHUB_USER}/${REPONAME}.git
#    git remote set-head origin develop
#    git config branch.develop.remote origin
# fi

        echo "********** DOTHIS: Manually make a change online GitHub file : "
        echo "Add to bottom of README.md \"Changed online\" and Save."
read "WAITING FOR RESPONSE: Press Enter/Return to continue:"

        echo "********** Making change that will be duplicated online : "
        echo -e "Change locally\r\n">>README.md

#        echo "********** Doing git pull to create conflict : "
# git pull
        echo "********** Doing git fetch a conflict : "
git fetch
git merge origin/develop

exit #51

# git stash save "text message here"

# git stash list /* shows whats in stash */
# git stash show -p stash@{0} /* Show the diff in the stash */

# git stash pop stash@{0} /*  restores the stash deletes the tash */
# git stash apply stash@{0} /*  restores the stash and keeps the stash */
# git stash drop stash@{0}
# git stash clear /*  removes all stash */


# Undo last commit, preserving local changes:
# git reset --soft HEAD~1

# Undo last commit, without preserving local changes:
# git reset --hard HEAD~1

# Undo last commit, preserving local changes in index:
# git reset --mixed HEAD~1

# Undo non-pushed commits:
# git reset origin/$DEFAULT_BRANCH


#     Revert a range of the last two commits:
# git revert HEAD~2..HEAD
# Create several revert commits:
# git revert a867b4af 25eee4ca 0766c053

# Reverting a merge commit
# git revert -m 1 <merge_commit_sha>
# See http://git-scm.com/blog/2010/03/02/undoing-merges.html


# From https://www.youtube.com/watch?v=sevc6668cQ0&t=41m40s
# git rebase master --exec "make test"

#         echo "******** Bisect loop : "
# for loop:
#     git bisect start
#     git bisect good master
#     git bisect run make test
# end loop

#         echo "******** Remote commands : "
# git fetch origin
# git reset --hard origin/$DEFAULT_BRANCH

#         echo "******** Cover your tracks:"
# Remove from repository all locally deleted files:
# git rm $(git ls-files --deleted)

# Move the branch pointer back to the previous HEAD:
# git reset --soft HEAD@{1}


# Commented out for cleanup at start of next run:
# cd ..
# rm -rf ${REPONAME}

        echo "******** $NOW end."
