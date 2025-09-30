# ~/nixos/pkgs/dotify.nix
{ stdenv
, fetchurl
, dpkg
, makeWrapper
, patchelf
, lib
, webkitgtk_4_1
, libappindicator-gtk3
, glib
, gtk3
, libsoup_3
, curl
, openssl
, cairo
, pango
, gdk-pixbuf
, glibc
}:

stdenv.mkDerivation rec {
  pname = "dotify";
  version = "2.0.7";

  src = fetchurl {
    url = "https://sourceforge.net/projects/dotify/files/dotify/Dotify_${version}_amd64.deb/download";
    sha256 = "a596a19b91c845b27f7cf9bd7b81314d8b7086168c444cbc36908546dc300cd6";
  };

  nativeBuildInputs = [ dpkg makeWrapper patchelf ];
  buildInputs = [
    webkitgtk_4_1
    libappindicator-gtk3
    glib
    gtk3
    libsoup_3
    curl
    openssl
    cairo
    pango
    gdk-pixbuf
    glibc
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out
    cp -r usr/* $out/

    # Исправление интерпретатора ELF
    find $out -type f -executable | while read -r bin; do
      if patchelf --print-interpreter "$bin" 2>/dev/null | grep -q ld-linux; then
        echo "Patching interpreter for $bin"
        patchelf --set-interpreter "${glibc}/lib/ld-linux-x86-64.so.2" "$bin"
      fi
    done

    # Обёртка для установки переменных среды
    for bin in $out/bin/*; do
      if [ -f "$bin" ] && [ -x "$bin" ]; then
        wrapProgram "$bin" \
          --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}"
      fi
    done
  '';

  meta = with lib; {
    description = "Dotify";
    homepage = "https://sourceforge.net/projects/dotify/";
    license = licenses.unfreeRedistributable;
    platforms = [ "x86_64-linux" ];
  };
}