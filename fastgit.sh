#!/bin/bash

fle="$1"
fle2="$2"

if [ "$fle" = "--help" ]
then
    echo "fastgit - add, commit and push one or two files in one command"
    echo ""
    echo "usage: fastgit filename1 [filename2]"
    echo ""
    echo "what it does:"
    echo "  1. checks you are inside a git repo"
    echo "  2. checks the file(s) exist"
    echo "  3. runs git add, git commit and git push on them"
    exit 0
fi

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1
then
    echo "warning youre not inside git repo!!"
    exit 1
fi

if [ -z "$fle" ]
then
    echo "usage: fastgit filename1 [filename2]"
    exit 1
fi

if [ ! -f "$fle" ]
then
    echo "warning: $fle does not exist"
    exit 1
fi

if [ -n "$fle2" ] && [ ! -f "$fle2" ]
then
    echo "warning: $fle2 does not exist"
    exit 1
fi

if [ -z "$fle2" ]
then
    if ! git add "$fle"
    then
        echo "warning: git add fail"
        exit 1
    fi

    if ! git commit -m "Update $fle"
    then
        echo "warning:commit fail"
        exit 1
    fi
else
    if ! git add "$fle" "$fle2"
    then
        echo "warning: git add fail"
        exit 1
    fi

    if ! git commit -m "Update $fle and $fle2"
    then
        echo "warning:commit fail"
        exit 1
    fi
fi

if ! git push
then
    echo "warining push failed"
    exit 1
fi

echo "done"
