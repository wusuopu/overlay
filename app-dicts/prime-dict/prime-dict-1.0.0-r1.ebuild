# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/prime-dict/prime-dict-1.0.0-r1.ebuild,v 1.5 2013/03/30 18:12:00 jer Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19 ree18 jruby"

inherit ruby-ng

DESCRIPTION="Dictionary files for PRIME input method"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc ppc64 ~sparc x86"
IUSE=""

each_ruby_configure() {
	econf --with-rubydir="$(ruby_rbconfig_value 'sitelibdir')" || die
}

each_ruby_compile() {
	emake || die
}

each_ruby_install() {
	emake DESTDIR="${D}" install || die
}

all_ruby_install() {
	dodoc AUTHORS ChangeLog NEWS README || die
}
