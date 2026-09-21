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
## Updates

- You can now add **2 files at the same time**
- Added `--dry-run` option
- Added `--push` option

Example:

```bash
fastgit README.md main.c
```

Another example:

```bash
fastgit "file one.txt" "file two.txt"
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
fastgit --dry-run filename "commit message"
fastgit --push filename "commit message"
fastgit --dry-run --push filename "commit message"
```

Example:

```bash
fastgit README.md
```

Example with 2 files:

```bash
fastgit README.md main.c
```

## Basic Setup

Clone the repository:

```bash
git clone https://github.com/nxseif/fast-git.git
cd fast-git
```

Make FastGit executable:

```bash
chmod +x fastgit
```

Move FastGit to your local bin folder:

```bash
mkdir -p ~/.local/bin
mv fastgit ~/.local/bin/fastgit
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
Created by **nxseif** — personal project to make using Git less suffering and more beginner friendly
