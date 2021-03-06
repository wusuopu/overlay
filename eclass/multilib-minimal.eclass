# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/multilib-minimal.eclass,v 1.2 2013/04/07 16:56:14 mgorny Exp $

# @ECLASS: multilib-minimal.eclass
# @MAINTAINER:
# Julian Ospald <hasufell@gentoo.org>
# @BLURB: wrapper for multilib builds providing convenient multilib_src_* functions
# @DESCRIPTION:
#
# src_configure, src_compile, src_test and src_install are exported.
#
# Use multilib_src_* instead of src_* which runs this phase for
# all enabled ABIs.
#
# multilib-minimal should _always_ go last in inherit order!
#
# If you want to use in-source builds, then you must run
# multilib_copy_sources at the end of src_prepare!
# Also make sure to set correct variables such as
# ECONF_SOURCE=${S}
#
# If you need generic install rules, use multilib_src_install_all function.


# EAPI=5 is required for meaningful MULTILIB_USEDEP.
case ${EAPI:-0} in
	5) ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac


inherit multilib-build

EXPORT_FUNCTIONS src_configure src_compile src_test src_install


multilib-minimal_src_configure() {
	multilib-minimal_abi_src_configure() {
		mkdir -p "${BUILD_DIR}" || die
		pushd "${BUILD_DIR}" >/dev/null || die
		if declare -f multilib_src_configure >/dev/null ; then
			multilib_src_configure
		else
			default_src_configure
		fi
		popd >/dev/null || die
	}

	multilib_foreach_abi multilib-minimal_abi_src_configure
}

multilib-minimal_src_compile() {
	multilib-minimal_abi_src_compile() {
		pushd "${BUILD_DIR}" >/dev/null || die
		if declare -f multilib_src_compile >/dev/null ; then
			multilib_src_compile
		else
			default_src_compile
		fi
		popd >/dev/null || die
	}

	multilib_foreach_abi multilib-minimal_abi_src_compile
}

multilib-minimal_src_test() {
	multilib-minimal_abi_src_test() {
		pushd "${BUILD_DIR}" >/dev/null || die
		if declare -f multilib_src_test >/dev/null ; then
			multilib_src_test
		else
			default_src_test
		fi
		popd >/dev/null || die
	}

	multilib_foreach_abi multilib-minimal_abi_src_test
}

multilib-minimal_src_install() {
	multilib-minimal_abi_src_install() {
		pushd "${BUILD_DIR}" >/dev/null || die
		if declare -f multilib_src_install >/dev/null ; then
			multilib_src_install
		else
			default_src_install	
		fi
		multilib_prepare_wrappers
		multilib_check_headers
		popd >/dev/null || die
	}
	multilib_foreach_abi multilib-minimal_abi_src_install
	multilib_install_wrappers

	if declare -f multilib_src_install_all >/dev/null ; then
		multilib_src_install_all
	fi
}
