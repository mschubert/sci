# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/libquo/libquo-1.2.2.ebuild,v 1.1 2015/01/06 21:56:20 ottxor Exp $

EAPI=5

inherit autotools-utils

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="git://github.com/losalamos/${PN}.git http://github.com/losalamos/${PN}.git"
	inherit git-r3
	KEYWORDS=""
	AUTOTOOLS_AUTORECONF=1
else
	SRC_URI="http://losalamos.github.io/${PN}/dists/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="run-time tuning of process binding policies made easy"
HOMEPAGE="http://losalamos.github.io/libquo/"

LICENSE="BSD"
SLOT="0"
IUSE="fortran static-libs"

DEPEND="
	virtual/mpi[fortran?]
	sys-process/numactl
	sys-apps/hwloc[numa,xml]
	"
RDEPEND="${DEPEND}"

src_configure() {
	autotools-utils_src_configure CC=mpicc FC=$(usex fortran mpif90 false)
}
