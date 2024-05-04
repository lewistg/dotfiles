#!/usr/bin/bash
#
# This script can be used to install the dot files in this repository onto a
# new machine. The script was developed following [this][1] tutorial by @duran
# of Atlassian.
#
# [1]: https://www.atlassian.com/git/tutorials/dotfiles

set -euo pipefail

readonly DOT_FILES_REPO="git@github.com:lewistg/dotfiles.git"
readonly DOT_FILES_DIR=.my-dot-files

git clone --bare "$DOT_FILES_REPO" "$DOT_FILES_DIR"
echo "$DOT_FILES_DIR" >> .gitignore
git --git-dir="$DOT_FILES_DIR" config --local status.showUntrackedFiles no
git --git-dir="$DOT_FILES_DIR" checkout -- '!install.sh'
