# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-woody-allen-it/fortune-mod-woody-allen-it-0.1.ebuild,v 1.4 2010/12/11 16:20:44 grobian Exp $

DESCRIPTION="Fortune database for Woody Allen quotes (in Italian)"
HOMEPAGE="http://somemixedstuff.blogspot.com/2007/04/set-of-fortunes-of-woody-allen-quotes.html"
SRC_URI="http://utenti.lycos.it/gutter/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}"/${PN}

src_install() {
	insinto /usr/share/fortune
	doins ${PN} ${PN}.dat || die "doins failed"
}
