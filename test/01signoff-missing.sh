#!/bin/sh
# Test whether missing signoff causes rejection.

set -e -x

. ./common-setup.sh

cat > trivial.patch <<-EOF
	From 88460bc61f56546da478dc6fd4682e7c62cc6c80 Mon Sep 17 00:00:00 2001
	From: Other person <other@example.com>
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

! bash "${INITDIR}"/../pram --no-gitconfig -e true -G -I -s ./trivial.patch 2> out.txt

diff -u - out.txt <<-EOF
	Commit no. 0001 was not signed off by the author!
EOF
