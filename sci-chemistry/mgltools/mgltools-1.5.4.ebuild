# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PLUGINS="autodocktools bhtree cmolkit dejavu geomutils gle mglutil molkit networkeditor opengltk pmv
	pyautodock pybabel pyglf qslimlib scenario sff stride support symserv utpackages viewer-framework
	vision visionlib volume webservices"

DESCRIPTION="Software to visualization and analysis of molecular structures"
HOMEPAGE="http://mgltools.scripps.edu/"
SRC_URI="http://mgltools.scripps.edu/downloads/tars/releases/REL${PV}/mgltools_source_${PV}.tar.gz"

LICENSE="MGLTOOLS"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"/${PN}_source_${PV}

for plug in ${PLUGINS}; do
	PLUG_DEP="${PLUG_DEP} =sci-chemistry/mgltools-${plug}-${PV}"
done

RDEPEND="${PLUG_DEP}
	dev-lang/tk
	sci-libs/msms
	>=dev-python/pmw-1.3
	dev-python/imaging
	dev-python/numpy"
DEPEND="${RDEPEND}"

src_install() {
	insinto /usr/share/${PN}
	doins -r Data || die
}
