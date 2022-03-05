# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit git-r3 python-single-r1

DESCRIPTION="Application for generating color variatons of GTK themes and terminal palette"
HOMEPAGE="https://github.com/themix-project/oomox"

# Simplest way to get all repos for now
EGIT_REPO_URI="https://github.com/themix-project/oomox.git"
EGIT_COMMIT="${PV}"
EGIT_SUBMODULES=('*')

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+base16 +icons-archdroid +icons-gnomecolors +icons-numix +icons-papirus +icons-suruplus +icons-suruplus-aspromauros +importcolors +spotify +theme-arc +theme-materia +theme-oomox"

# Still have to figure out what goes in which *DEPEND properly
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DEPEND="
	${PYTHON_DEPS}
	x11-apps/xrdb
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
	')

	theme-arc? (
		dev-lang/sassc
		dev-libs/glib:2
		dev-util/meson
		media-gfx/inkscape
		media-gfx/optipng
		sys-apps/findutils
		sys-apps/grep
		sys-apps/sed
		x11-libs/gdk-pixbuf:2
		x11-themes/gtk-engines-murrine
	)

	theme-materia? (
		dev-lang/sassc
		dev-libs/glib:2
		dev-util/meson
		media-gfx/inkscape
		media-gfx/optipng
		sys-apps/findutils
		sys-apps/grep
		sys-apps/sed
		sys-process/parallel
		x11-libs/gdk-pixbuf:2
		x11-themes/gtk-engines-murrine
	)

	theme-oomox? (
		dev-lang/sassc
		dev-libs/glib:2
		gnome-base/librsvg:2
		sys-apps/findutils
		sys-apps/grep
		sys-apps/sed
		sys-devel/bc
		x11-libs/gdk-pixbuf:2
	)

	icons-archdroid? (
		sys-apps/findutils
		sys-apps/sed
	)

	icons-gnomecolors? (
		gnome-base/librsvg:2
		media-gfx/imagemagick
		sys-apps/findutils
		sys-apps/grep
		sys-apps/sed
		sys-devel/bc
	)

	icons-numix? (
		sys-apps/findutils
		sys-apps/sed
	)

	icons-papirus? (
		sys-apps/findutils
		sys-apps/sed
	)

	icons-suruplus? (
		sys-apps/findutils
		sys-apps/sed
	)

	icons-suruplus-aspromauros? (
		sys-apps/findutils
		sys-apps/sed
	)

	spotify? (
		app-arch/zip
		sys-apps/grep
		sys-devel/bc
		sys-auth/polkit
	)

	importcolors? (
		$(python_gen_cond_dep '
			dev-python/pillow[${PYTHON_USEDEP}]
		')
	)

	base16? (
		$(python_gen_cond_dep '
			dev-python/pystache[${PYTHON_USEDEP}]
			dev-python/pyyaml[${PYTHON_USEDEP}]
		')
	)
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.13.3-make-jobserver.patch
	"${FILESDIR}"/${PN}-1.13.3-metainfo-dir.patch
)

src_install() {
	local makeopts=(
		DESTDIR="${D}"
		APPDIR="/opt/${PN}"
		PREFIX="${EPREFIX}/usr"
		install_gui
		$(usex theme-arc install_theme_arc '')
		$(usex theme-materia install_theme_materia '')
		$(usex theme-oomox install_theme_oomox '')
		$(usex icons-archdroid install_icons_archdroid '')
		$(usex icons-gnomecolors install_icons_gnomecolors '')
		$(usex icons-numix install_icons_numix '')
		$(usex icons-papirus install_icons_papirus '')
		$(usex icons-suruplus install_icons_suruplus '')
		$(usex icons-suruplus-aspromauros install_icons_suruplus_aspromauros '')
		$(usex base16 install_plugin_base16 '')
		$(usex importcolors install_import_images '')
		$(usex spotify install_export_oomoxify '')
	)
	emake "${makeopts[@]}"
}
