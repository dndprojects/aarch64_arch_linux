#\rm -rf plex_pkg
#rm -rf plex-media-server-1.15.0.573-2-aarch64.pkg.tar.xz
#wget -r -nH --cut-dirs=2 --no-parent --reject="index.html*" http://mypogo.x10.mx/arch_linux/aarch64/plex_pkg/
set pkg_name=`\ls -1 plex_pkg/*xz0 | sed "s#plex_pkg/##" | sed "s#xz0#xz#g"`
set last=`\ls -1 plex_pkg/*xz* | wc -l`
@ last -= 1
cat plex_pkg/${pkg_name}[0-$last] > $pkg_name
pacman --noconfirm -U  $pkg_name
