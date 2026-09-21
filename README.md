**# FastGit**

Small bash script for automation of common git commands.

Instead of writing:

**`bash**  **git add**   **git commit**   **git push**  **`**

I just run:

**`bash**  **fastgit** \<filename>   **fastgit** \<filename1> \<filename2>  **fastgit --help**  **fastgit --version**  **`**

FastGit checks if you're inside a git repo, checks if the file exists, adds it, commits it a>

It also checks if **`git add`**, **`git commit`** or **`git push`** fail and shows an error.

**## What I added**

***** Check if you're inside a Git repository
***** Check if a filename was given
***** Check if the file exists
***** Automatic **`git add`**
***** Automatic **`git commit`**
***** Automatic **`git push`**
***** Basic error handling
***** Works with filenames using variables and quotes
***** You can now add ****2 files at the same time****
*** `--help`** option
*** `--version`** option

**## Updates**

***** You can now add ****2 files at the same time****.

Example:

**`bash**  **fastgit README.md main.c**  **`**

Another example:

**`bash**  **fastgit "file one.txt" "file two.txt"**  **`**

**## Technologies**

***** Bash
***** Linux
***** Git
***** GitHub

**## Usage**

**`bash**  **fastgit filename**  **fastgit filename1 filename2**  **fastgit --help**   **fastgit --version**  **`**

Example:

**`bash**  **fastgit README.md**  **`**

Example with 2 files:

**`bash**  **fastgit README.md main.c**  **`**

Created by ****nxseif**** – personal project to make it less suffering using git beginner friend>

**## Basic setup**

Clone the repository:

**`bash** **git clone https://github.com/nxseif/fast-git.git** **cd fast-git** **`**

Make FastGit executable:

**`bash** **chmod +x fastgit** **`**

Move FastGit to your local bin folder:

**`bash** **mkdir -p ~/.local/bin** **mv fastgit ~/.local/bin/fastgit** **`**

Add it to your PATH:

**`bash** **echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc** **source ~/.bashrc** **`**

Now you can use:

**`bash** **fastgit --help** **`**
