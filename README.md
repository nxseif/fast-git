# FastGit 

A lightweight Bash utility that simplifies common Git workflows with a single command.

FastGit helps you stage and commit multiple files, optionally push changes to GitHub, and access useful Git shortcuts directly from your terminal.

Built with Bash while learning Linux, Git, and shell scripting.

## Features

- Add and commit multiple files in one command
- Support filenames containing spaces
- Optional interactive commit-message prompt
- Optional push with `--push`
- Dry-run mode with `--dry-run`
- Combine `--push` and `--dry-run`
- Initialize new local Git repositories
- Set the initial branch to `main`
- Optionally configure a Git remote during setup
- Validate files before staging them
- Detect Git operation failures
- Detect when there is nothing to commit
- Handle the first push when a branch has no upstream
- Check for an `origin` remote before pushing
- List local Git repositories with `gf repos`
- Switch repositories with `gf repo <name>` using a Bash function
- Shortcuts for status, diff, branch, log, help, and version

## Requirements

- Linux or another Unix-like environment
- Bash
- Git
- A configured Git identity for committing
- A GitHub account and remote repository if you want to push to GitHub

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/nxseif/fast-git.git
cd fast-git
```

### 2. Make the script executable

```bash
chmod +x fastgit.sh
```

### 3. Create your local bin directory

```bash
mkdir -p ~/.local/bin
```

### 4. Install FastGit

```bash
cp fastgit.sh ~/.local/bin/fastgit
```

### 5. Add the directory to your PATH

If `~/.local/bin` is not already in your PATH, add it to your `~/.bashrc`:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 6. Create the `gf` shortcut

```bash
ln -s ~/.local/bin/fastgit ~/.local/bin/gf
```

If the `gf` link already exists, you do not need to create it again.

Check the installation:

```bash
gf version
gf help
```

## Usage

### Basic syntax

```bash
gf [--dry-run] [--push] file1 [file2 ...] -m "commit message"
```

The options must appear before the filenames.

- `file1` is the first file to stage.
- `[file2 ...]` represents any additional files.
- `-m` introduces the commit message.
- `--dry-run` previews the operation without committing or pushing.
- `--push` pushes the commit after a successful commit.

### Add and commit one file

```bash
gf README.md -m "update readme"
```

Equivalent Git commands:

```bash
git add README.md
git commit -m "update readme"
```

FastGit does not push by default.

### Add and commit multiple files

```bash
gf README.md main.c script.sh -m "update project files"
```

You can supply additional filenames without changing the script.

### Filenames containing spaces

Quote filenames that contain spaces:

```bash
gf "file one.txt" "file two.txt" "notes file.md" -m "add project files"
```

Each quoted filename is passed to Git as a separate argument.

### Interactive commit message

You can omit `-m` and enter the commit message when prompted, provided you supply only filenames:

```bash
gf README.md main.c
```

FastGit asks:

```text
commit message:
```

Enter your message and press Enter.

If you provide `-m`, the message is taken from the remaining arguments.

## Push to a remote repository

FastGit does not push automatically. Use `--push` when you want to push after committing:

```bash
gf --push README.md main.c -m "update project"
```

FastGit checks whether an `origin` remote exists before pushing.

If the current branch has no upstream, it attempts the initial push using:

```bash
git push -u origin <branch>
```

If the branch already has an upstream, FastGit uses:

```bash
git push
```

A successful push completes the add, commit, and push workflow.

## Dry-run mode

Use `--dry-run` to preview the planned operation without staging files, creating a commit, or pushing.

```bash
gf --dry-run README.md main.c script.sh -m "test changes"
```

Example output:

```text
dry run - nothing was actually done
would run: git add "README.md" "main.c" "script.sh"
would run: git commit -m "test changes"
```

### Preview a push

```bash
gf --dry-run --push README.md main.c -m "test push"
```

Example output:

```text
dry run - nothing was actually done
would run: git add "README.md" "main.c"
would run: git commit -m "test push"
would run: git push
```

The dry-run option can be combined with `--push` to preview the workflow without performing it.

## Automatic repository setup

FastGit can initialize a new local Git repository when run in a directory without an existing `.git` directory.

For example:

```bash
mkdir my-project
cd my-project
touch README.md
```

Then run:

```bash
gf README.md -m "initial commit"
```

FastGit initializes the repository and sets the initial branch to `main`.

During setup, it asks for an optional remote URL:

```text
enter your new gitHub repo url (or press enter to skip):
```

You can provide an existing repository URL or press Enter to skip.

**Note:** FastGit initializes the local repository and can configure a remote. It does not create a new GitHub repository automatically.

## Repository discovery

List Git repositories found within the configured search depth of your home directory:

```bash
gf repos
```

FastGit uses `find` to search for `.git` directories:

```bash
find ~ -maxdepth 3 -type d -name ".git"
```

The command displays repository names and their paths.

## Repository navigation

FastGit also supports:

```bash
gf repo nxvpn
```

This feature is implemented through a Bash function in `gf-function.sh`, because a normal executable cannot change the working directory of the shell that launched it.

### Enable repository navigation

Copy the function file:

```bash
cp gf-function.sh ~/.local/bin/gf-function.sh
```

Add it to your Bash configuration:

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
gf repo nxvpn
```

## Git shortcuts

| Command | Description |
|---|---|
| `gf status` | Show Git status |
| `gf diff` | Show unstaged changes |
| `gf branch` | Display the current branch |
| `gf log` | Show the last five commits |
| `gf version` | Display the FastGit version |
| `gf help` | Display usage information |
| `gf repos` | List discovered repositories |
| `gf repo <name>` | Switch to a repository |

## Error handling

FastGit performs checks during the workflow, including:

- Verifying that the current directory belongs to a Git repository
- Checking that supplied files exist
- Handling failures from `git add` and `git commit`
- Detecting when there is nothing to commit
- Checking for an `origin` remote before pushing
- Handling push failures

Example warning:

```text
warning: README.md does not exist
```

FastGit exits when a supplied file cannot be found instead of continuing with the staging operation.

## Project structure

```text
fast-git/
├── fastgit.sh
├── gf-function.sh
└── README.md
```

**`fastgit.sh`**

The main script handles argument parsing, file validation, Git operations, dry-run mode, repository discovery, and Git shortcuts.

**`gf-function.sh`**

Contains the Bash function required for repository navigation with `gf repo <name>`.

## Technologies

- Bash
- Linux
- Git
- GitHub

## Why I built it

FastGit started as a small project to make repetitive Git commands easier to use from the terminal.

As I learned Bash, Linux, and Git, I gradually added features such as multi-file support, dry-run mode, repository discovery, error handling, and optional pushing.

The project is intentionally kept lightweight and built around a Bash script rather than a larger application.

## Version

**Current version: v1.8.1**

Check your installed version with:

```bash
gf version
```

## Author

Created by **nxseif**

*Making Git less suffering, one command at a time. 😭*
