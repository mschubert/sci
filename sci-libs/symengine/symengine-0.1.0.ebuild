# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils

DESCRIPTION="Fast symbolic manipulation library, written in C++"
HOMEPAGE="https://github.com/sympy/symengine"
SRC_URI="https://github.com/sympy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="python ruby threads openmp boost"

DEPEND="
	dev-libs/jemalloc
	dev-libs/gmp
	boost? ( dev-libs/boost )
	python? ( dev-lang/python:= )
	ruby? ( dev-lang/ruby:= )"
RDEPEND="${DEPEND}"

CMAKE_BUILD_TYPE=Release

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX:PATH="${EPREFIX}"/usr \
		$(cmake-utils_use_with boost) \
		$(cmake-utils_use_with python) \
		$(cmake-utils_use_with ruby) \
		$(cmake-utils_use_with openmp)
	)

	if use threads; then
		mycmakeargs+=(
			-DWITH_TCMALLOC:BOOL=ON \
			-DWITH_PTHREAD:BOOL=ON \
			-DWITH_SYMENGINE_THREAD_SAFE:BOOL=ON
		)
	fi

	cmake-utils_src_configure
}
