# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/biblatex/biblatex-2.1.ebuild,v 1.1 2012/07/31 14:06:19 aballier Exp $

EAPI=4

inherit latex-package

DESCRIPTION="Reimplementation of the bibliographic facilities provided by LaTeX"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/biblatex"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="LPPL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-texlive/texlive-bibtexextra"
DEPEND="${RDEPEND}"

S=${WORKDIR}
TEXMF=/usr/share/texmf-site

src_install() {
	insinto "${TEXMF}/tex/latex/${PN}"
	doins -r latex/*
	for i in bibtex/* ; do
		insinto "${TEXMF}/${i}/${PN}"
		doins ${i}/*
	done

	use doc && { pushd doc ; latex-package_src_doinstall doc ; popd ; }
	dodoc README RELEASE
}
