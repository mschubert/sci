# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Chunked, compressed, N-dimensional arrays for Python"
HOMEPAGE="
	https://zarr.readthedocs.io/
	https://github.com/zarr-developers/zarr-python
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/donfig[${PYTHON_USEDEP}]
	dev-python/google-crc32c[${PYTHON_USEDEP}]
	dev-python/msgspec[${PYTHON_USEDEP}]
	>=dev-python/numcodecs-0.16[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/typer[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( hypothesis pytest-asyncio )
distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# network access
		tests/test_store/test_core.py::test_make_store_path_fsspec
	)
	local EPYTEST_IGNORE=(
		# tests take a long time
		tests/benchmarks
		# numpydoc not available for py3.12
		tests/test_api/test_synchronous.py
		# additional deps
		tests/test_docs.py
		# uv installs dependencies from the network
		tests/test_examples.py
		tests/test_regression/scripts
	)
	epytest -o addopts= tests
}
