self: super:
  let
    rust = self.rustChannelOf { channel = "1.41.0"; };
  in {
    rusty-blog = self.callPackage ./pkgs/rusty-blog {
      inherit (self.darwin.apple_sdk.frameworks) Security;
      rustPlatform = super.makeRustPlatform {
        rustc = rust.rust;
	cargo = rust.cargo;
      };
    };
}
