# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/vc/vc-1.48.ebuild,v 1.6 2011/07/22 11:24:59 xarthisius Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Version Control for Free systems."
PKG_CAT="standard"

RDEPEND="app-xemacs/dired
app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/ediff
app-xemacs/sh-script
app-xemacs/pcl-cvs
app-xemacs/tramp
app-xemacs/prog-modes
app-xemacs/elib
app-xemacs/edebug
app-xemacs/gnus
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
