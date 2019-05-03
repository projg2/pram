# (this is intended to be sourced from other tests)

INITDIR=${PWD}
TMPDIR=$(mktemp -d)
trap 'rm -r -f "${TMPDIR}"' EXIT

# Use predefined timestamp to get reproducible repo.
export GIT_AUTHOR_DATE='2000-01-01 00:00:00Z'
export GIT_COMMITTER_DATE='2000-01-01 00:00:00Z'

cd "${TMPDIR}"
git init
git config --local user.name 'PRam test'
git config --local user.email 'pram@example.com'
cat > data.txt <<-EOF
	This is some initial data.

	001100
	010010
	011110
	100001
	101101
	110011
EOF
git add data.txt
git commit -m 'Initial commit'
