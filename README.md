# FastGit

Small bash script for automation of common git commands.

Instead of writing:

```bash
git add
git commit
git push
```

I just run:

```bash
fastgit <filename>
fastgit --help show help information
fastgit --version show version information
```

FastGit checks if you're inside a git repo, checks if the file exists, adds it, commits it and pushes it to GitHub.

It also checks if `git add`, `git commit` or `git push` fail and shows an error.

## What I added

* Check if you're inside a Git repository
* Check if a filename was given
* Check if the file exists
* Automatic `git add`
* Automatic `git commit`
* Automatic `git push`
* Basic error handling
* Works with filenames using variables and quotes

## Technologies

* Bash
* Linux
* Git
* GitHub

## Usage

```bash
fastgit filename
fastgit --help
fastgit --version
```

Example:

```bash
fastgit filename
```

Created by **nxseif** – personal project to make it less sufuring using git beginner friendly

