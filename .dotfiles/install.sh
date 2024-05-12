#!/usr/bin/bash
#
# This script can be used to install the dot files in this repository onto a
# new machine. The script was developed following [this][1] tutorial by @duran
# of Atlassian.
#
# [1]: https://www.atlassian.com/git/tutorials/dotfiles

set -euo pipefail

readonly DOT_FILES_REPO="git@github.com:lewistg/dotfiles.git"
export readonly GIT_WORK_TREE="$(dirname "$0")"
export readonly GIT_DIR="$GIT_WORK_TREE/.dotfiles-git"

git clone --bare "$DOT_FILES_REPO" "$GIT_DIR"

echo "$GIT_DIR" >> .gitignore
git config --local status.showUntrackedFiles no
git checkout

# Install git helpers for bash shell. See git book [1].
#
# [1]: https://git-scm.com/book/pl/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Bash
installed_git_helpers="false"
while true; do
    read -p "Install git's bash helpers? (Y/n) " yes_or_no
    case "$yes_or_no" in
        Y)
            BASE_URL="https://raw.githubusercontent.com/git/git/master/contrib/completion"
            curl \
                "$BASE_URL/git-completion.bash" \
                -o "$GIT_WORK_TREE/.dotfiles/git-completion.bash"
            curl \
                "$BASE_URL/git-prompt.sh" \
                -o "$GIT_WORK_TREE/.dotfiles/git-prompt.sh"
            installed_git_helpers="true"
            break
            ;;
        [Nn])
            break
            ;;
    esac
done

echo "Finished installation, but you'll need to perform the following manual step(s):"
echo ""
if [ "$installed_git_helpers" = "true" ]; then
    cat - <<-EOF
		To use git's bash prompt feature, you'll need to update your PS1 environment
		variable. Adapted from the git book [1], you can use the following snippet as a
		starting point:
		\`\`\`
		. ~/.dotfiles/git-prompt.sh
		export GIT_PS1_SHOWDIRTYSTATE=1
		export PS1='\w\$(__git_ps1 " (%s)")\\$ '
		\`\`\`
		Add your finalized version of the snippet to your \`.bashrc\`.
	EOF
fi

echo ""
echo 'Add the following snippets to your `.bashrc` file:'
cat - <<-EOF
	\`\`\`
	# Source shell settings from dotfiles
	. .dotfiles/.bashrc-annex
	\`\`\`

	\`\`\`
	# To commit local changes to the dotfile repo, use the \`dfgit\` tool. \`dfgit\` is
	# a simple wrapper around git that makes it easier to make changes to the
	# dotfiles bare repo in $GIT_DIR
	export PATH="\$PATH:$GIT_WORK_TREE/.dotfiles/dfgit
	\`\`\`
EOF
