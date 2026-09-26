# FastGit

Small Bash script for making common Git commands easier.

Instead of writing:

```bash
git add
git commit
git push
```

I can just run:

```bash
gf README.md "update readme"
```

FastGit checks if you're inside a Git repository, checks if the file exists, adds it, commits it, and can push it.

It also checks if `git add`, `git commit`, or `git push` fail and shows an error.

## What I Added

* Check if you're inside a Git repository
* Check if a filename was given
* Check if the file exists
* Automatic `git add`
* Automatic `git commit`
* Optional `git push`
* Basic error handling
* Support for filenames with spaces
* Add **2 files at the same time**
* `help` command
* `version` command
* `status` command
* `log` command
* `branch` command
* `diff` command
* `--dry-run` option
* `--push` option
* Use `--push` and `--dry-run` together
* Find local Git repositories with `gf repos`
* Switch between repositories with `gf repo <name>`
* Handle the first push of a branch without an upstream

## Updates

* You can now add **2 files at the same time**
* Added `--dry-run` option
* Added `--push` option
* Added `status` command
* Added `log` command
* Added `branch` command
* Added `diff` command
* Improved option handling so `--push` and `--dry-run` can be used together in any order
* Added repository discovery with `gf repos`
* Added repository navigation with `gf repo <name>`
* Added `gf-function.sh` for repository navigation
* Added first-push handling for branches without an upstream

## Examples

Add and commit one file:

```bash
gf README.md "update readme"
```

Add and commit two files:

```bash
gf README.md main.c "update files"
```

Files with spaces are also supported:

```bash
gf "file one.txt" "file two.txt" "update files"
```

If you don't give a commit message, FastGit asks for one:

```bash
gf README.md
```

```text
commit message:
```

## Dry Run

`--dry-run` shows what FastGit would do without actually changing anything.

```bash
gf --dry-run README.md "test commit"
```

This is useful when you want to check the command before running it.

## Push

FastGit does not push by default.

Use `--push` when you want to push the commit:

```bash
gf --push README.md "update readme"
```

`--push` and `--dry-run` can also be used together:

```bash
gf --dry-run --push README.md "test push"
```

The order doesn't matter:

```bash
gf --push --dry-run README.md "test push"
```

## Repository Navigation

FastGit can find Git repositories in your home directory.

List your repositories:

```bash
gf repos
```

Example:

```text
your repositories:

oryx
/home/v/projects/oryx

project-web
/home/v/projects/project-web

nxvpn
/home/v/projects/nxvpn

fast-git
/home/v/fast-git

netchecker
/home/v/netchecker
```

You can then switch directly to a repository:

```bash
gf repo <name>
```

Example:

```bash
gf repo nxvpn
```

This changes the current terminal directory to the selected repository.

So instead of:

```bash
cd ~/projects/nxvpn
```

you can just use:

```bash
gf repo nxvpn
```

The `gf repo` feature is implemented as a Bash function in `gf-function.sh`.

## Git Commands

Check Git status:

```bash
gf status
```

Show unstaged changes:

```bash
gf diff
```

Show the current branch:

```bash
gf branch
```

Show the last 5 commits:

```bash
gf log
```

Show the FastGit version:

```bash
gf version
```

Show help:

```bash
gf help
```

## Quick Reference

```text
gf filename "commit message"
gf filename1 filename2 "commit message"

gf help
gf version
gf status
gf diff
gf branch
gf log

gf --dry-run filename "commit message"
gf --push filename "commit message"

gf --dry-run --push filename "commit message"
gf --push --dry-run filename "commit message"

gf repos
gf repo <name>
```

## Technologies

* Bash
* Linux
* Git
* GitHub

## Setup

Clone the repository:

```bash
git clone https://github.com/nxseif/fast-git.git
cd fast-git
```

Make FastGit executable:

```bash
chmod +x fastgit.sh
```

Create your local bin folder:

```bash
mkdir -p ~/.local/bin
```

Copy FastGit to your local bin folder:

```bash
cp fastgit.sh ~/.local/bin/fastgit
```

Copy the `gf` repository navigation function:

```bash
cp gf-function.sh ~/.local/bin/gf-function.sh
```

Add your local bin folder to `PATH`:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Short `gf` command

Create the `gf` shortcut:

```bash
ln -s ~/.local/bin/fastgit ~/.local/bin/gf
```

You can now use:

```bash
gf help
gf version
gf status
gf README.md "update readme"
```

### Enable `gf repo`

The repository navigation feature needs to be loaded as a Bash function because `cd` must change the directory of the current terminal.

Add the function to your `.bashrc`:

```bash
echo 'source ~/.local/bin/gf-function.sh' >> ~/.bashrc
```

Then reload your Bash configuration:

```bash
source ~/.bashrc
```

Now you can use:

```bash
gf repos
```

or:

```bash
gf repo nxvpn
```

Check that it works:

```bash
gf repo <repository-name>
```

## About

FastGit is a personal Bash project I made to make using Git a little less annoying.

I'm building it step by step while learning Bash, Git, and Linux.

Created by **nxseif** — making Git less suffering, one command at a time.
