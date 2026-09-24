#!/bin/bash

fle="$1"
dry_run="no"
push="no"


if [ "$fle" = "--diff" ]
then 
	git diff
	exit 0
fi


if [ "$fle" = "--branch" ]
then 
	git branch --show-current
	exit 0
fi


if [ "$fle" = "--log" ]
then 
	git log --oneline -5

exit 0 
fi 


if [ "$fle" = "--status" ]
then 
	git status 
exit 0

fi


if [ "$fle" = "--version" ]
then
        echo "fastgit v1.6"
        exit 0
fi


if [ "$fle" = "--help" ]
then
    echo "fastgit - add, commit and push one or two files in one command"
    echo ""
    echo "usage: fastgit [--dry-run] [--push] filename1 [filename2] \"commit message\""
    echo ""
    echo "flags:"
    echo "  --dry-run   show what would happen, don't change anything"
    echo "  --push      also push after committing (default is no push)"
    echo ""
    echo "if you leave out the commit message, fastgit will ask for it"
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


if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1
then
    echo "warning youre not inside git repo"
    exit 1
fi

if [ -z "$fle" ]
then
    echo "usage: fastgit [--dry-run] [--push] filename1 [filename2] \"commit message\""
    exit 1
fi

if [ ! -f "$fle" ]
then
    echo "warning: $fle does not exist"
    exit 1
fi

if [ -f "$2" ]
then
    fle2="$2"
    msg="$3"
else
    fle2=""
    msg="$2"
fi

if [ -n "$fle2" ] && [ ! -f "$fle2" ]
then
    echo "warning: $fle2 does not exist"
    exit 1
fi

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
    echo "dry run - nothing was actually done"
    if [ -n "$fle2" ]
    then
        echo "would run: git add \"$fle\" \"$fle2\""
    else
        echo "would run: git add \"$fle\""
    fi
    echo "would run: git commit -m \"$msg\""
    if [ "$push" = "yes" ]
    then
        echo "would run: git push"
    fi
    exit 0
fi

if [ -n "$fle2" ]
then
    if ! git add "$fle" "$fle2"
    then
        echo "warning: git add fail"
        exit 1
    fi
else
    if ! git add "$fle"
    then
        echo "warning: git add fail"
        exit 1
    fi
fi

if ! git commit -m "$msg"
then
    echo "warning:commit fail"
    exit 1
fi

if [ "$push" = "yes" ]
then
    if ! git push
    then
        echo "warining push failed"
        exit 1
    fi
    echo "done :  added committed and pushed"
    exit 0
fi

echo "done : added and committed  not pushed (use --push to also push)"
exit 0
