# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/luvit/luvit-9999.ebuild,v 1.2 2013/03/05 21:09:17 hasufell Exp $

EAPI=5

inherit toolchain-funcs multilib git-2

# TODO: FHS https://github.com/luvit/luvit/issues/379

DESCRIPTION="Takes node.js' architecture and dependencies and fits it in the Lua language"
HOMEPAGE="http://luvit.io/"
EGIT_REPO_URI="git://github.com/luvit/luvit.git"

KEYWORDS=""
SLOT="0"
IUSE="examples +system-libs"
# luvit Apache-2.0
# luajit MIT
# yajl BSD
LICENSE="Apache-2.0 MIT !system-libs? ( BSD )"

# fails in portage environment
# succeeds if run manually
RESTRICT="test"

RDEPEND="
	dev-libs/openssl:0
	sys-libs/zlib
	system-libs? (
		>=dev-libs/yajl-2.0.4
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

EGIT_HAS_SUBMODULES=1

src_prepare() {
	if use system-libs ; then
		MY_YAJL_VERSION=$(pkg-config --modversion yajl)
	else
		MY_YAJL_VERSION=$(git --git-dir deps/yajl/.git describe --tags)
	fi
	MY_HTTP_VERSION=$(git --git-dir deps/http-parser/.git describe --tags)
	MY_UV_VERSION=$(git --git-dir deps/uv/.git describe --all --long | cut -f 3 -d -)

	sed \
		-e "s:^YAJL_VERSION=.*:YAJL_VERSION=${MY_YAJL_VERSION}:" \
		-e "s:^LUAJIT_VERSION=.*:LUAJIT_VERSION=${MY_LUAJIT_VERSION}:" \
		-e "s:^HTTP_VERSION=.*:HTTP_VERSION=${MY_HTTP_VERSION}:" \
		-e "s:^UV_VERSION.*:UV_VERSION=${MY_UV_VERSION}:" \
		-i Makefile || die "sed failed"

	sed -i \
		-e "s/-Werror//" \
		-e "s/-O3//" \
		deps/http-parser/Makefile || die "fixing flags failed!"
}

src_configure() {
	# skip retarded gyp build system
	:
}

src_compile() {
	tc-export CC AR

	myemakeargs=(
		DEBUG=0
		WERROR=0
		USE_SYSTEM_SSL=1
		# bundled luajit is compiled with special flags
		USE_SYSTEM_LUAJIT=0
		USE_SYSTEM_ZLIB=1
		USE_SYSTEM_YAJL=$(usex system-libs "1" "0")
		PREFIX=/usr
		LIBDIR="${D}"/usr/$(get_libdir)/${PN}
		DESTDIR="${D}"
	)

	emake "${myemakeargs[@]}" all
}

src_install() {
	emake "${myemakeargs[@]}" install
	dodoc TODO ChangeLog README.markdown errors.markdown

	if use examples ; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
