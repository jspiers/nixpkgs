{
  lib,
  stdenv,
  fetchFromGitLab,
  rustPlatform,
  meson,
  ninja,
  pkg-config,
  rustc,
  cargo,
  wrapGAppsHook4,
  desktop-file-utils,
  libxml2,
  libadwaita,
  openssl,
  libsoup_3,
  webkitgtk_6_0,
  sqlite,
}:

stdenv.mkDerivation rec {
  pname = "read-it-later";
  version = "0.5.0";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "World";
    repo = "read-it-later";
    rev = version;
    hash = "sha256-A8u1fecJAsVlordgZmUJt/KZWxx6EWMhfdayKWHTTFY=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-DgqFdihMVKWMdbGEmyGH9yXkC9Ywmh7FcmFtLBCJeDc=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    rustPlatform.cargoSetupHook
    rustc
    cargo
    wrapGAppsHook4
    desktop-file-utils
    libxml2.bin # xmllint
  ];

  buildInputs = [
    libadwaita
    openssl
    libsoup_3
    webkitgtk_6_0
    sqlite
  ];

  meta = with lib; {
    description = "Simple Wallabag client with basic features to manage articles";
    homepage = "https://gitlab.gnome.org/World/read-it-later";
    changelog = "https://gitlab.gnome.org/World/read-it-later/-/releases/${src.rev}";
    license = licenses.gpl3Plus;
    mainProgram = "read-it-later";
    maintainers = with maintainers; [ aleksana ];
    platforms = platforms.unix;
  };
}
