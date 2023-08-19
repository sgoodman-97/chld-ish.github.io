#!/bin/zsh

setopt -e
#setopt -x

local -r tidy=/usr/local/bin/tidy
if ! [[ -x $tidy ]]; then
	cat <<EOT >&2
Please install HTML5 Tidy using the command \`brew install tidy-html5\`. Note that there is an ancient version of tidy
installed with macOS into /usr/bin/tidy, but that is not the one we need, the one we need will be installed via Homebrew
at $tidy.
EOT
	exit 1
fi

cd $0:h
find docs -iname \*.html -print0 | \
	xargs -0 -n 1 \
	$tidy -q -e --gnu-emacs true --strict-tags-attributes true --drop-empty-elements false
