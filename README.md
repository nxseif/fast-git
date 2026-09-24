# FastGit

Small Bash script for automation of common Git commands.

Instead of writing:

```bash
git add
git commit
git push
```

I just run:

```bash
fastgit <filename>
fastgit <filename1> <filename2>
fastgit --help
fastgit --version
```

FastGit checks if you're inside a Git repo, checks if the file exists, adds it, commits it, and can push it.

It also checks if `git add`, `git commit`, or `git push` fail and shows an error.

## What I Added

* Check if you're inside a Git repository
* Check if a filename was given
* Check if the file exists
* Automatic `git add`
* Automatic `git commit`
* Automatic `git push`
* Basic error handling
* Works with filenames using variables and quotes
* You can now add **2 files at the same time**
* `--help` option
* `--version` option
* `--dry-run` option
* `--push` option
* `--status` option
* `--log` option
* `--branch` option
* `--diff` option
* `--push` and `--dry-run` can now be used together in any order

## Updates

* You can now add **2 files at the same time**
* Added `--dry-run` option
* Added `--push` option
* Added `--status` option
* Added `--log` option
* Added `--branch` option
* Added `--diff` option
* Improved option handling so `--push` and `--dry-run` can be used together in any order

Example:

```bash
fastgit README.md main.c
```

Another example:

```bash
fastgit "file one.txt" "file two.txt"
```

You can also use the shorter `gf` command:

```bash
gf README.md
```

## Technologies

* Bash
* Linux
* Git
* GitHub

## Usage

```bash
fastgit filename
fastgit filename1 filename2
fastgit --help
fastgit --version
fastgit --status
fastgit --log
fastgit --branch
fastgit --diff
fastgit --dry-run filename "commit message"
fastgit --push filename "commit message"
fastgit --dry-run --push filename "commit message"
fastgit --push --dry-run filename "commit message"
```

Example:

```bash
fastgit README.md
```

Example with 2 files:

```bash
fastgit README.md main.c
```

Check Git status:

```bash
fastgit --status
```

Show the last 5 commits:

```bash
fastgit --log
```

Show the current branch:

```bash
fastgit --branch
```

Show unstaged changes:

```bash
fastgit --diff
```

## Basic Setup

Clone the repository:

```bash
git clone https://github.com/nxseif/fast-git.git
cd fast-git
```

Make FastGit executable:

```bash
chmod +x fastgit.sh
```

Move FastGit to your local bin folder:

```bash
mkdir -p ~/.local/bin
mv fastgit.sh ~/.local/bin/fastgit
```

Add it to your PATH:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Now you can use FastGit from anywhere:

```bash
fastgit --help
```

### Optional: Use the shorter `gf` command

Create a shortcut to FastGit:

```bash
ln -s ~/.local/bin/fastgit ~/.local/bin/gf
```

Now you can use:

```bash
gf --help
gf --version
gf --status
gf README.md
```

Check that the command is available:

```bash
which gf
```

Created by **nxseif** — personal project to make using Git less suffering and more beginner friendly
