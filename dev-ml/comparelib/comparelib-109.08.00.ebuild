# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/comparelib/comparelib-109.08.00.ebuild,v 1.1 2013/02/08 23:30:12 aballier Exp $

EAPI="5"

inherit oasis

DESCRIPTION="Camlp4 syntax extension that derives comparison functions from type representations"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-ml/type-conv-3.0.5:="
RDEPEND="${DEPEND}"

DOCS=( "README.txt" )
