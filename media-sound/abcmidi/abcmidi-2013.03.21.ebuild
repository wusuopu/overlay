# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcmidi/abcmidi-2013.03.21.ebuild,v 1.1 2013/03/23 09:40:05 radhermit Exp $

EAPI=5

inherit eutils versionator autotools

MY_P="abcMIDI-$(replace_all_version_separators '-')"
DESCRIPTION="Programs for processing ABC music notation files"
HOMEPAGE="http://abc.sourceforge.net/abcMIDI/"
SRC_URI="http://ifdo.pugmarks.com/~seymour/runabc/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="app-arch/unzip"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2011.10.19-install.patch
	rm configure makefile || die
	sed -i -e "s:-O2::" configure.ac || die
	eautoreconf
}

src_install() {
	default
	dodoc doc/{AUTHORS,CHANGES,abcguide.txt,abcmatch.txt,history.txt,readme.txt,yapshelp.txt}

	if use examples ; then
		docinto examples
		dodoc samples/*.abc
	fi
}
