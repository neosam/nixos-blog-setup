{ stdenv, rustPlatform, fetchFromGitHub, llvmPackages, pkgconfig, less
, Security, libiconv, installShellFiles, makeWrapper
}:

rustPlatform.buildRustPackage rec {
  pname   = "rusty-blog";
  version = "0.0.1-1";

  src = fetchFromGitHub {
    owner  = "neosam";
    repo   = pname;
    rev    = "v${version}";
    sha256 = "0s5jdgrfkbflnxprr4ddinxylbxf4m2g6wihadrj76x4b3g7w22l";
    fetchSubmodules = true;
  };

  cargoSha256 = "1nm9vryjhf9rszyhag69zdfljmklxbm6jdvflcv8zj1ynp5cqfwv";

  nativeBuildInputs = []; #[ pkgconfig llvmPackages.libclang installShellFiles makeWrapper ];

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
