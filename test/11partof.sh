#!/bin/sh
# Test whether the Part-of trailer is correctly added to every commit.

set -e -x

. ./common-setup.sh

cat > three-commits.patch <<-EOF
	From 243f5779c2ae9b0d117829b60fe7dbc466e968c0 Mon Sep 17 00:00:00 2001
	From: PRam test <pram@example.com>
	Date: Sat, 1 Jan 2000 00:00:00 +0000
	Subject: [PATCH 1/3] First patch

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
	From: PRam test <pram@example.com>
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
	From: PRam test <pram@example.com>
	Date: Sat, 1 Jan 2000 00:00:00 +0000
	Subject: [PATCH 3/3] Third patch

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

# Test without signoff so we're only testing one thing
bash "${INITDIR}"/../pram --no-gitconfig -e true -G -I -S --part-of-pr 123 ./three-commits.patch

git log --format='%ae%n%an%n%aI%n%B' -3 > git-log.txt
diff -u - git-log.txt <<-EOF
	pram@example.com
	PRam test
	2000-01-01T00:00:00Z
	Third patch

	Part-of: https://github.com/gentoo/gentoo/pull/123

	pram@example.com
	PRam test
	2000-01-01T00:00:00Z
	Second patch

	Part-of: https://github.com/gentoo/gentoo/pull/123

	pram@example.com
	PRam test
	2000-01-01T00:00:00Z
	First patch

	Part-of: https://github.com/gentoo/gentoo/pull/123

EOF
sha256sum -c <<-EOF
	c95bc3022ee967e117fc7841d9b6597e672d7ef1da7897b2c2692fe8b099911d  data.txt
EOF