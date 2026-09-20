#!/bin/bash

fle="$1"

if [ "$fle" = "--version" ]
then
echo "FastGit version 1.1.0"
exit 0 
fi

if [ "$fle" = "--help" ]
then
    echo "fastgit - add, commit and push a file in one command"
    echo ""
    echo "usage: fastgit filename"
    echo ""
    echo "what it does:"
    echo "  1. checks you are inside a git repo"
    echo "  2. checks the file exists"
    echo "  3. runs git add, git commit and git push on it"
    exit 0
fi

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1
then
    echo "warning youre not inside git repo!!"
    exit 1
fi

if [ -z "$fle" ]
then
    echo "usage: fastgit filename"
    exit 1
fi

if [ ! -f "$fle" ]
then
    echo "warning: file does not exist"
    exit 1
fi

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

if ! git push
then
    echo "warining push failed"
    exit 1
fi

echo "done"
