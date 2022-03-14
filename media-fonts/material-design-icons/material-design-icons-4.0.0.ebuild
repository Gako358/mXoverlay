# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Google's Material Design icons fonts (all themes)"
HOMEPAGE="https://google.github.io/material-design-icons/"
SRC_URI="https://github.com/google/material-design-icons/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

FONT_SUFFIX="otf ttf"
FONT_S="${S}/font"
