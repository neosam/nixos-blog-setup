{ stdenv, rustPlatform, fetchFromGitHub, llvmPackages, pkgconfig, less
, Security, libiconv, installShellFiles, makeWrapper
}:

rustPlatform.buildRustPackage rec {
  pname   = "rusty-blog";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner  = "neosam";
    repo   = pname;
    rev    = "v${version}";
    sha256 = "1257nm9vi1rrlj7l3az73na2byw3rhqxyn6lwh3fp0xkyzsrxjpf";
    fetchSubmodules = true;
  };

  cargoSha256 = "1dm3dnz89483sls7fswyhdg64z6wf8jzxd404bb8wljxydp4nvbf";

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
