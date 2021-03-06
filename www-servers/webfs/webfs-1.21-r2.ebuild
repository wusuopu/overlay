# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/webfs/webfs-1.21-r2.ebuild,v 1.8 2013/02/19 05:01:01 zmedico Exp $

EAPI=4
inherit eutils

DESCRIPTION="Lightweight HTTP server for static content"
SRC_URI="http://dl.bytesex.org/releases/${PN}/${P}.tar.gz"
HOMEPAGE="http://linux.bytesex.org/misc/webfs.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~arm-linux ~x86-linux"
IUSE="ssl threads"

DEPEND="ssl? ( dev-libs/openssl )"

RDEPEND="${DEPEND}
	app-misc/mime-types"

src_prepare() {
	epatch "${FILESDIR}/webfs-1.21-Variables.mk-dont-strip-binaries-on-install.patch"
	sed -e "s:/etc/mime.types:${EPREFIX}\\0:" -i GNUmakefile || die "sed failed"
}

src_compile() {
	local myconf
	use ssl || myconf="${myconf} USE_SSL=no"
	use threads && myconf="${myconf} USE_THREADS=yes"

	emake prefix="${EPREFIX}/usr" ${myconf}
}

src_install() {
	local myconf
	use ssl || myconf="${myconf} USE_SSL=no"
	use threads && myconf="${myconf} USE_THREADS=yes"
	einstall ${myconf} mandir="${ED}/usr/share/man"
	newinitd "${FILESDIR}"/${PN}.initd-r1 ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	dodoc README
}
