# FastGit 🚀

Small Bash script for making common Git commands easier.

Instead of writing:

```bash
git add README.md
git commit -m "update readme"
git push
```

You can use:

```bash
gf --push README.md "update readme"
```

FastGit handles adding, committing, and optionally pushing files from one command.

It also includes useful Git shortcuts, repository discovery, dry-run mode, basic error handling, and automatic setup for a new local Git repository.

---

## Features

* Add and commit one file
* Add and commit two files
* Support filenames with spaces
* Optional Git push with `--push`
* Dry-run mode with `--dry-run`
* Use `--push` and `--dry-run` together in any order
* Automatic `git init` for new directories
* Set the initial branch to `main`
* Optional remote configuration during first-time setup
* Detect whether you're inside a Git repository
* Check whether files exist before adding them
* Check whether Git operations fail
* Detect when there is nothing to commit
* Handle the first push of a branch without an upstream
* Check for an `origin` remote before pushing
* List Git repositories with `gf repos`
* Repository navigation with `gf repo <name>`
* Git shortcuts for status, diff, branch, and log
* Help and version commands

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/nxseif/fast-git.git
cd fast-git
```

### 2. Make FastGit executable

```bash
chmod +x fastgit.sh
```

### 3. Create your local bin directory

```bash
mkdir -p ~/.local/bin
```

### 4. Copy FastGit

```bash
cp fastgit.sh ~/.local/bin/fastgit
```

### 5. Add `~/.local/bin` to your PATH

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 6. Create the `gf` shortcut

```bash
ln -s ~/.local/bin/fastgit ~/.local/bin/gf
```

You can now run:

```bash
gf help
```

---

# Usage

## Add and commit one file

```bash
gf README.md "update readme"
```

FastGit will run the equivalent of:

```bash
git add README.md
git commit -m "update readme"
```

It does **not** push unless `--push` is used.

---

## Add and commit two files

```bash
gf README.md main.c "update files"
```

FastGit supports filenames containing spaces:

```bash
gf "file one.txt" "file two.txt" "update files"
```

---

## Commit message prompt

If you don't provide a commit message:

```bash
gf README.md
```

FastGit asks:

```text
commit message:
```

You can then enter your commit message normally.

---

# Push

FastGit does not push by default.

Use `--push` when you want to push the commit:

```bash
gf --push README.md "update readme"
```

FastGit checks whether an `origin` remote exists before pushing.

If the current branch does not have an upstream, FastGit automatically uses:

```bash
git push -u origin <branch>
```

After a successful push:

```text
done: added, committed, and pushed
```

Without `--push`:

```text
done: added and committed (not pushed; use --push to push)
```

---

# Dry Run

`--dry-run` shows what FastGit would do without actually changing anything.

```bash
gf --dry-run README.md "test commit"
```

Example:

```text
dry run - nothing was actually done
would run: git add "README.md"
would run: git commit -m "test commit"
```

With `--push`:

```bash
gf --dry-run --push README.md "test push"
```

Output:

```text
dry run - nothing was actually done
would run: git add "README.md"
would run: git commit -m "test push"
would run: git push
```

The order of the options does not matter:

```bash
gf --dry-run --push README.md "test push"
```

or:

```bash
gf --push --dry-run README.md "test push"
```

---

# New Repository Setup

FastGit can initialize a directory that isn't already a Git repository.

For example:

```bash
mkdir my-project
cd my-project
touch README.md
```

Then:

```bash
gf README.md "initial commit"
```

FastGit detects that `.git` does not exist and initializes the repository.

It runs:

```bash
git init
git branch -M main
```

It then asks:

```text
Enter your new GitHub repo URL (or press Enter to skip):
```

You can enter an existing remote repository URL, for example:

```text
https://github.com/nxseif/my-project.git
```

FastGit adds it as:

```bash
git remote add origin <url>
```

You can then push using:

```bash
gf --push README.md "initial commit"
```

### Important

FastGit initializes the **local** Git repository and can connect it to a remote repository.

It does **not** create a new GitHub repository automatically.

---

# Repository Discovery

FastGit can search your home directory for local Git repositories.

Run:

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

FastGit searches up to three directory levels inside your home directory.

It uses:

```bash
find ~ -maxdepth 3 -type d -name ".git"
```

---

# Repository Navigation

FastGit also includes `gf repo <name>` for quickly switching to a repository.

Example:

```bash
gf repo nxvpn
```

Instead of:

```bash
cd ~/projects/nxvpn
```

FastGit changes your current terminal directory to the selected repository.

### Why is this a Bash function?

A normal executable cannot change the directory of the shell that launched it.

Because of this, the `gf repo` command is implemented through:

```text
gf-function.sh
```

---

## Enable `gf repo`

Copy the function file:

```bash
cp gf-function.sh ~/.local/bin/gf-function.sh
```

Add it to `.bashrc`:

```bash
echo 'source ~/.local/bin/gf-function.sh' >> ~/.bashrc
```

Reload Bash:

```bash
source ~/.bashrc
```

You can now use:

```bash
gf repos
```

and:

```bash
gf repo nxvpn
```

---

# Git Shortcuts

FastGit also provides shortcuts for common Git commands.

### Status

```bash
gf status
```

Equivalent to:

```bash
git status
```

---

### Diff

```bash
gf diff
```

Equivalent to:

```bash
git diff
```

---

### Current branch

```bash
gf branch
```

Equivalent to:

```bash
git branch --show-current
```

---

### Recent commits

```bash
gf log
```

Shows the last five commits:

```bash
git log --oneline -5
```

---

### Version

```bash
gf version
```

Example:

```text
fastgit v1.8.0
```

---

### Help

```bash
gf help
```

Displays the available commands and options.

---

# Quick Reference

| Command                              | Description                 |
| ------------------------------------ | --------------------------- |
| `gf file "message"`                  | Add and commit one file     |
| `gf file1 file2 "message"`           | Add and commit two files    |
| `gf --push file "message"`           | Add, commit and push        |
| `gf --dry-run file "message"`        | Show what would happen      |
| `gf --dry-run --push file "message"` | Preview a push operation    |
| `gf status`                          | Show Git status             |
| `gf diff`                            | Show unstaged changes       |
| `gf branch`                          | Show current branch         |
| `gf log`                             | Show last 5 commits         |
| `gf version`                         | Show FastGit version        |
| `gf help`                            | Show help                   |
| `gf repos`                           | Find local Git repositories |
| `gf repo <name>`                     | Switch to a repository      |

---

# Error Handling

FastGit performs several checks before and during Git operations.

It checks:

* Whether the current directory is a Git repository
* Whether a filename was provided
* Whether the file exists
* Whether `git add` succeeds
* Whether there is anything to commit
* Whether `git commit` succeeds
* Whether an `origin` remote exists before pushing
* Whether `git push` succeeds

Example:

```text
warning: README.md does not exist
```

or:

```text
warning: git add failed
```

---

# How It Works

The main script follows this general process:

```text
Arguments
   │
   ├── help / version / status / log / branch / diff
   │
   └── normal command
          │
          ▼
     Parse options
          │
          ▼
   Check Git repository
          │
          ▼
     Check files
          │
          ▼
   Get commit message
          │
          ▼
       git add
          │
          ▼
   Check staged changes
          │
          ▼
      git commit
          │
          ▼
    --push specified?
       /       \
     no         yes
     │           │
     ▼           ▼
   Done      git push
```

---

# Project Structure

```text
fast-git/
├── fastgit.sh
├── gf-function.sh
└── README.md
```

### `fastgit.sh`

Main FastGit script.

Handles:

* Argument parsing
* Git repository detection
* File validation
* `git add`
* `git commit`
* optional `git push`
* dry-run mode
* Git shortcuts
* repository discovery

### `gf-function.sh`

Contains the Bash function needed for:

```bash
gf repo <name>
```

The function is required because `cd` needs to affect the current shell.

---

# Technologies

* Bash
* Linux
* Git
* GitHub

---

# Why I Built It

FastGit started as a small Bash script to make repetitive Git commands less annoying.

Instead of repeatedly typing:

```bash
git add
git commit
git push
```

I wanted a simple command that could handle the common workflow:

```bash
gf README.md "update readme"
```

Then I kept adding features while learning Bash, Linux, and Git.

The project is intentionally built as a Bash script rather than a large application.

---

# Version

Current version:

```text
v1.8.0
```

Check it with:

```bash
gf version
```

---

## Author

Created by **nxseif**

Making Git less suffering, one command at a time. 😭

