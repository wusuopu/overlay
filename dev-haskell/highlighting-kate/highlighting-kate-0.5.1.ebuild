# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/highlighting-kate/highlighting-kate-0.5.1.ebuild,v 1.2 2012/09/12 14:49:13 qnikst Exp $

EAPI=4

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Syntax highlighting"
HOMEPAGE="http://github.com/jgm/highlighting-kate"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="executable pcre-light"

RDEPEND=">=dev-haskell/blaze-html-0.4.2[profile?]
		<dev-haskell/blaze-html-0.6[profile?]
		dev-haskell/mtl[profile?]
		dev-haskell/parsec[profile?]
		pcre-light? ( dev-haskell/pcre-light[profile?] )
		!pcre-light? ( dev-haskell/regex-pcre-builtin[profile?] )
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

src_configure() {
	cabal_src_configure \
		$(cabal_flag executable) \
		$(cabal_flag pcre-light)
}
