# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/olsrd/olsrd-0.6.3.ebuild,v 1.3 2012/08/21 15:40:09 johu Exp $

EAPI=4
inherit eutils multilib toolchain-funcs versionator

MY_PV=$(replace_version_separator 3 '-r')
DESCRIPTION="An implementation of the Optimized Link State Routing protocol"
HOMEPAGE="http://www.olsr.org/"
SRC_URI="http://www.olsr.org/releases/$(get_version_component_range 1-2)/${PN}-${MY_PV}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 x86"
IUSE="gtk"
DEPEND="
	gtk? (
		dev-libs/glib:2
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:2
	)
"
RDEPEND=$DEPEND
S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	epatch \
		"${FILESDIR}/${PN}-0.6.1-build_fix.patch" \
		"${FILESDIR}/${P}-make-gtk.patch"
}

src_compile() {
	emake LIBDIR="/usr/$(get_libdir)/${PN}" OS=linux CC="$(tc-getCC)" build_all
	if use gtk; then
		emake -C "${S}/gui/linux-gtk" LIBDIR="/usr/$(get_libdir)/${PN}" CC="$(tc-getCC)"
	fi
}

src_install() {
	emake OS=linux LIBDIR="${D}/usr/$(get_libdir)/${PN}" \
		DESTDIR="${D}" STRIP=true install_all
	if use gtk; then
		emake -C "${S}/gui/linux-gtk" \
			LIBDIR="${D}/usr/$(get_libdir)/${PN}" DESTDIR="${D}" install
	fi

	doinitd "${FILESDIR}/olsrd"

	dodoc CHANGELOG \
		valgrind-howto.txt files/olsrd.conf.default.rfc \
		files/olsrd.conf.default.lq files/olsrd.conf.default.lq-fisheye \
		lib/arprefresh/README_ARPREFRESH \
		lib/bmf/README_BMF \
		lib/dot_draw/README_DOT_DRAW \
		lib/dyn_gw/README_DYN_GW \
		lib/dyn_gw_plain/README_DYN_GW_PLAIN \
		lib/httpinfo/README_HTTPINFO \
		lib/mini/README_MINI \
		lib/nameservice/README_NAMESERVICE \
		lib/pgraph/README_PGRAPH \
		lib/quagga/README_QUAGGA \
		lib/secure/README_SECURE \
		lib/txtinfo/README_TXTINFO \
		lib/watchdog/README_WATCHDOG
}
