# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/colord/colord-0.1.26.ebuild,v 1.10 2013/01/20 17:08:22 ago Exp $

EAPI="5"
VALA_MIN_API_VERSION="0.18"
VALA_USE_DEPEND="vapigen"

inherit autotools bash-completion-r1 eutils user systemd base udev vala

DESCRIPTION="System service to accurately color manage input and output devices"
HOMEPAGE="http://www.freedesktop.org/software/colord/"
SRC_URI="http://www.freedesktop.org/software/colord/releases/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0/1" # subslot = libcolord soname version
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="doc examples +gusb +introspection +udev vala" #systemd
REQUIRED_USE="vala? ( introspection )"

COMMON_DEPEND="
	dev-db/sqlite:3=
	>=dev-libs/glib-2.28.0:2
	>=media-libs/lcms-2.2:2=
	>=sys-auth/polkit-0.103
	gusb? ( >=dev-libs/libgusb-0.1.1 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.8 )
	udev? ( virtual/udev:=[gudev] )"
#	systemd? ( >=sys-apps/systemd-44 )
RDEPEND="${COMMON_DEPEND}
	media-gfx/shared-color-profiles"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.9 )
	vala? ( $(vala_depend) )"

# FIXME: needs pre-installed dbus service files
RESTRICT="test"

pkg_setup() {
	enewgroup colord
	enewuser colord -1 -1 /var/lib/colord colord
}

src_prepare() {
	use vala && vala_src_prepare

	epatch "${FILESDIR}/${PN}-0.1.26-fix-automagic-systemd.patch"
	eautoreconf
}

src_configure() {
	# Reverse tools require gusb
	econf \
		--disable-examples \
		--disable-static \
		--enable-polkit \
		--disable-volume-search \
		--with-daemon-user=colord \
		--localstatedir="${EPREFIX}"/var \
		$(use_enable doc gtk-doc) \
		$(use_enable gusb) \
		$(use_enable gusb reverse) \
		$(use_enable introspection) \
		--disable-libsystemd-login \
		$(use_enable udev gudev) \
		--with-udevrulesdir="$(udev_get_udevdir)"/rules.d \
		$(use_enable vala) \
		"$(systemd_with_unitdir)"
	#	$(use_enable systemd libsystemd-login) \

	# parallel make fails in doc/api
	use doc && MAKEOPTS="${MAKEOPTS} -j1"
}

src_install() {
	DOCS=(AUTHORS ChangeLog MAINTAINERS NEWS README TODO)
	default

	newbashcomp client/colormgr-completion.bash colormgr
	rm -vr "${ED}etc/bash_completion.d"

	# Ensure config and profile directories exist and /var/lib/colord/*
	# is writable by colord user
	keepdir /var/lib/color{,d}/icc
	fowners colord:colord /var/lib/colord{,/icc}

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
	fi

	prune_libtool_files --modules
}
