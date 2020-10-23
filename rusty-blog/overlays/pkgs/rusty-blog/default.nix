{ stdenv, rustPlatform, fetchFromGitHub, llvmPackages, pkgconfig, less
, Security, libiconv, installShellFiles, makeWrapper
}:

rustPlatform.buildRustPackage rec {
  pname   = "rusty-blog";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner  = "neosam";
    repo   = pname;
    rev    = "v${version}";
    sha256 = "0awfvm7bir00ywwvfwg6vhbixgipllpf5gdpd2685wp9pksvcbm7";
    fetchSubmodules = true;
  };

  cargoSha256 = "0ang9bd27h1yp8q5vfg5q4r3lrqlgsvap9kx3b8pvjcj1239c8rm";

  nativeBuildInputs = []; #[ pkgconfig llvmPackages.libclang installShellFiles makeWrapper ];
  legacyCargoFetcher = true;

  buildInputs = stdenv.lib.optionals stdenv.isDarwin [ Security libiconv ];

  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  meta = with stdenv.lib; {
    description = "A blog software";
    homepage    = https://github.com/neosam/rusty-blog;
    license     = with licenses; [ asl20 /* or */ mit ];
#     maintainers = with maintainers; [ dywedir lilyball ];
    platforms   = platforms.all;
  };
}
