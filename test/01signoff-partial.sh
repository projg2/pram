#!/bin/sh
# Test whether a set of commits where only one is missing causes rejection.

set -e -x

. ./common-setup.sh

cat > three-commits.patch <<-EOF
	From 243f5779c2ae9b0d117829b60fe7dbc466e968c0 Mon Sep 17 00:00:00 2001
	From: Other person <other@example.com>
	Date: Sat, 1 Jan 2000 00:00:00 +0000
	Subject: [PATCH 1/3] First patch

	Signed-off-by: Other person <other@example.com>

	---
	 data.txt | 2 +-
	 1 file changed, 1 insertion(+), 1 deletion(-)

	diff --git a/data.txt b/data.txt
	index 5baade6..a9a301d 100644
	--- a/data.txt
	+++ b/data.txt
	@@ -1,6 +1,6 @@
	 This is some initial data.

	-001100
	+001101
	 010010
	 011110
	 100001
	--
	2.49.0

	From 7aab19414dd17546985fd7c0091e779944e8f0df Mon Sep 17 00:00:00 2001
	From: Other person <other@example.com>
	Date: Sat, 1 Jan 2000 00:00:00 +0000
	Subject: [PATCH 2/3] Second patch

	---
	 data.txt | 2 +-
	 1 file changed, 1 insertion(+), 1 deletion(-)

	diff --git a/data.txt b/data.txt
	index a9a301d..237b5ef 100644
	--- a/data.txt
	+++ b/data.txt
	@@ -1,7 +1,7 @@
	 This is some initial data.

	 001101
	-010010
	+010011
	 011110
	 100001
	 101101
	--
	2.49.0

	From 8be43d8aa258fd2c2cf25ec540d19ab6a25d4038 Mon Sep 17 00:00:00 2001
	From: Other person <other@example.com>
	Date: Sat, 1 Jan 2000 00:00:00 +0000
	Subject: [PATCH 3/3] Third patch

	Signed-off-by: Other person <other@example.com>

	---
	 data.txt | 2 +-
	 1 file changed, 1 insertion(+), 1 deletion(-)

	diff --git a/data.txt b/data.txt
	index 237b5ef..6ba7c31 100644
	--- a/data.txt
	+++ b/data.txt
	@@ -3,6 +3,6 @@ This is some initial data.
	 001101
	 010011
	 011110
	-100001
	+101101
	 101101
	 110011
	--
	2.49.0
EOF

! bash "${INITDIR}"/../pram --no-gitconfig -e true -G -I -s -P ./three-commits.patch 2> out.txt

diff -u - out.txt <<-EOF
	Commit no. 0002 was not signed off by the author!
EOF
