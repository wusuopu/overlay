# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby2ruby/ruby2ruby-1.2.4-r2.ebuild,v 1.13 2013/01/15 06:06:28 zerochaos Exp $

EAPI=2

USE_RUBY="ruby18 ree18"

# Don't run tests, since they require the testcase from ParseTree;
# ParseTree _is_ the testcase for ruby2ruby
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

inherit ruby-fakegem

DESCRIPTION="Generates readable ruby from ParseTree"
HOMEPAGE="http://seattlerb.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

ruby_add_rdepend "=dev-ruby/parsetree-3.0*
	=dev-ruby/sexp_processor-3.0*
	=dev-ruby/ruby_parser-2.0*"
ruby_add_bdepend doc "dev-ruby/hoe dev-ruby/hoe-seattlerb"
