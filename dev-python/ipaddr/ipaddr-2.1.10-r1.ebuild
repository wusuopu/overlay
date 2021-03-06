# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipaddr/ipaddr-2.1.10-r1.ebuild,v 1.2 2013/02/24 12:22:30 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Python IP address manipulation library"
HOMEPAGE="http://code.google.com/p/ipaddr-py/ http://pypi.python.org/pypi/ipaddr"
SRC_URI="http://ipaddr-py.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS=( README RELEASENOTES )

DISTUTILS_IN_SOURCE_BUILD=1

python_prepare() {
	if [[ ${EPYTHON} == python3* ]]; then
		2to3 -n -w --no-diffs *.py || die
	fi
}

python_test() {
	PYTHONPATH=build/lib \
		"${PYTHON}" ipaddr_test.py || die "Tests fail with ${EPYTHON}"
}
