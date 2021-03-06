# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/adzapper/adzapper-20110915-r2.ebuild,v 1.1 2013/03/18 11:56:48 tove Exp $

EAPI=5

MY_P=${P/zapper/zap}

inherit eutils

DESCRIPTION="Redirector for squid that intercepts advertising, page counters and some web bugs"
HOMEPAGE="http://adzapper.sourceforge.net/"
SRC_URI="http://adzapper.sourceforge.net/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl"

S="${WORKDIR}"/${P/per/}

src_prepare() {
	epatch "${FILESDIR}"/20110915-flush.patch
	# update the zapper path in various scripts
	local SCRPATH="/etc/adzapper/squid_redirect"
	sed -i \
		-e "s|^zapper=.*|zapper=${SCRPATH}|" \
		-e "s|^ZAPPER=.*|ZAPPER=\"${SCRPATH}\"|" \
		-e "s|^pidfile=.*|pidfile=/var/run/squid.pid|" \
		-e "s|^PIDFILE=.*|PIDFILE=\"/var/run/squid.pid\"|" \
		-e "s|^RESTARTCMD=.*|RESTARTCMD=\"/etc/init.d/squid restart\"|" \
		scripts/wrapzap scripts/update-zapper* \
		|| die "sed updating failed."
}

src_install() {
	exeinto /etc/adzapper
	doexe \
		scripts/wrapzap \
		scripts/zapchain \
		adblock-plus/adblockplus2adzapper.py
	newexe scripts/squid_redirect-nodata squid_redirect

	insinto /etc/adzapper
	doins scripts/update-zapper*

	insinto /var/www/localhost/htdocs/zap
	doins zaps/*
}

pkg_postinst() {
	einfo "To enable adzapper, add the following lines to /etc/squid/squid.conf:"
	einfo "    url_rewrite_program /etc/adzapper/wrapzap"
	einfo "    url_rewrite_children 10"
}
