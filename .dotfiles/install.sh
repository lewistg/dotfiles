#!/usr/bin/bash
#
# This script can be used to install the dot files in this repository onto a
# new machine. The script was developed following [this][1] tutorial by @duran
# of Atlassian.
#
# [1]: https://www.atlassian.com/git/tutorials/dotfiles

set -euo pipefail

readonly DOT_FILES_REPO="git@github.com:lewistg/dotfiles.git"
export readonly GIT_DIR=".dotfiles-git"

git clone --bare "$DOT_FILES_REPO" "$GIT_DIR"

echo "$GIT_DIR" >> .gitignore
git config --local status.showUntrackedFiles no
git checkout
