#!/bin/bash

fle="$1"
files=()
dry_run="no"
push="no"


if [ "$fle" = "repos" ]
then
        echo "your repositories: "

find ~ -maxdepth 3 -type d -name ".git" 2>/dev/null | while read -r repo
do
folder=$(dirname "$repo")
name=$(basename "$folder")

echo "$name"
echo "$folder"
echo""
done

exit 0
fi

if [ "$fle" = "diff" ]
then
        git diff
        exit 0
fi


if [ "$fle" = "branch" ]
then
        git branch --show-current
        exit 0
fi


if [ "$fle" = "log" ]
then
        git log --oneline -5

exit 0
fi


if [ "$fle" = "status" ]
then
        git status
exit 0

fi


if [ "$fle" = "version" ]
then
        echo "fastgit v1.9.2"
        exit 0
fi


if [ "$fle" = "help" ]
then
	echo "fastgit - add, commit and push multiple files in one command"
	echo ""
	echo 'usage: fastgit [--dry-run] [--push] file1 [file2 ...] -m "commit message"'
	echo ""
	echo "flags:"
	echo "  --dry-run   show what would happen, don't change anything"
	echo "  --push      also push after committing (default is no push)"
 	echo ""
	echo "if you leave out the commit message, fastgit will ask for it"
	echo " [ gf repos ] list your Git repositories  "
	echo " [ gf repo <name> ] switch to a repository "
  	exit 0
fi

while [ $# -gt 0 ]
do
        if [ "$1" = "--dry-run" ]
then
dry_run="yes"
shift

elif [ "$1" = "--push" ]
then
        push="yes"
shift


else
        break

fi
done

fle="$1"


if [ ! -d ".git" ]; then
    echo " first time setup: initializing new Git repository"
    git init
    git branch -M main

    echo -n "enter your new gitHub repo url (or press enter to skip): "
    read repo_url
if [ -n "$repo_url" ]; then
        git remote add origin "$repo_url"
    fi
fi


if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1
then
    echo "warning youre not inside git repo"
    exit 1
fi

if [ -z "$fle" ]
then
echo 'usage: fastgit [--dry-run] [--push] file1 [file2 ....] -m "commit message"'
    exit 1
fi








while [ $# -gt 0 ] && [ "$1" !=  "-m" ]
do
	files+=("$1")
shift

done



if [ "$1" = "-m" ]
then 
	shift
	msg="$*"
else
	msg=""
fi





for file in "${files[@]}"
do
	if [ ! -f "$file" ]

then
	echo "warning $file donsent exist "
	exit 1 
fi 
done 









if [ -z "$msg" ]
then
    read -p "commit message: " msg
fi

if [ -z "$msg" ]
then
    echo "warning: commit message is required"
    exit 1
fi








if [ "$dry_run" = "yes" ]
then
	echo "dry run  nothing was actually done"
	printf 'would run git add'
	printf ' "%s"' "${files[@]}"
echo ""


 echo "would run: git commit -m \"$msg\""


 if [ "$push" = "yes" ]
    then
        echo "would run: git push"
    fi
    exit 0
fi
























if ! git add "${files[@]}"
then
	echo "warning git add failed"
exit 1

fi









if git diff --cached --quiet
then
 echo "nothing to commit"

    if [ "$push" = "yes" ]
        then
        git push
 fi
         exit 0
fi


if ! git commit -m "$msg"
then
        echo"warning : commit failed"
        exit 1
fi



if  [ "$push" = "yes" ]
then
        if ! git remote get-url origin > /dev/null 2>&1
then
        echo "warning : no origin remote found "
        exit 1
fi

branch=$(git branch --show-current)
if git rev-parse --abbrev-ref --symbolic-full-name '@{u}' > /dev/null 2>&1
then

if ! git push

    then
        echo"warining push failed"
        exit 1
    fi

else
        if ! git push -u origin "$branch"
then
        echo "warning : first push failed"
        exit 1
    fi
fi

  echo "done :  added committed and pushed"
    exit 0
fi

echo "done : added and committed  not pushed (use --push to also push)"
exit 0
