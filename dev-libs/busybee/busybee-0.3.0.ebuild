# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/busybee/busybee-0.3.0.ebuild,v 1.1 2013/04/15 06:23:43 patrick Exp $
EAPI=4

DESCRIPTION="A messaging abstraction on top of TCP sockets used in HyperDex"

HOMEPAGE="http://hyperdex.org"
SRC_URI="http://hyperdex.org/src/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND="dev-libs/libpo6
	dev-libs/libe"
RDEPEND="${DEPEND}"
