# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-logger-qt/telepathy-logger-qt-0.5.3.ebuild,v 1.2 2013/04/12 17:48:26 scarabeus Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit kde4-base python-any-r1

DESCRIPTION="Qt4 bindings for the Telepathy logger"
HOMEPAGE="https://projects.kde.org/projects/extragear/network/telepathy/telepathy-logger-qt"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/kde-telepathy/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="debug"

RDEPEND="
	media-libs/qt-gstreamer
	>=net-im/telepathy-logger-0.2.12-r1
	>=net-libs/telepathy-qt-0.9.1
"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	${PYTHON_DEPS}
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	kde4-base_src_configure
}
