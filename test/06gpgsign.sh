#!/bin/sh
# Test GPG-signing.

set -e -x

. ./common-setup.sh

# Generate a temporary key.
export GNUPGHOME=${TMPDIR}/gpg
mkdir "${GNUPGHOME}"
gpg --batch --passphrase '' --quick-generate-key 'PRam test <pram@example.com>' || exit 77
git config --local user.signingkey pram@example.com

cat > trivial.patch <<-EOF
	From 88460bc61f56546da478dc6fd4682e7c62cc6c80 Mon Sep 17 00:00:00 2001
	From: PRam test <pram@example.com>
	Date: Sat, 1 Jan 2000 00:00:00 +0000
	Subject: [PATCH] A trivial patch

	---
	 data.txt    | 4 ++--
	 newfile.txt | 1 +
	 2 files changed, 3 insertions(+), 2 deletions(-)
	 create mode 100644 newfile.txt

	diff --git a/data.txt b/data.txt
	index 5baade6..0139962 100644
	--- a/data.txt
	+++ b/data.txt
	@@ -1,8 +1,8 @@
	 This is some initial data.

	 001100
	-010010
	-011110
	 100001
	+011110
	+010010
	 101101
	 110011
	diff --git a/newfile.txt b/newfile.txt
	new file mode 100644
	index 0000000..6d8bf33
	--- /dev/null
	+++ b/newfile.txt
	@@ -0,0 +1 @@
	+Also, a new file.
	--
	2.21.0
EOF

bash "${INITDIR}"/../pram --no-gitconfig -e true -I -S -P ./trivial.patch

git log --format='%ae%n%an%n%aI%n%G?%n%B' -1 > git-log.txt
diff -u - git-log.txt <<-EOF
	pram@example.com
	PRam test
	2000-01-01T00:00:00Z
	G
	A trivial patch

EOF
sha1sum -c <<EOF
8054584c7b1fa9b5bdd7ee1177e78c99ea2cce04  data.txt
810ded956f70861874e2c6083c5dc9e9e80f1808  newfile.txt
EOF
