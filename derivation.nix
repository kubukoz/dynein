{ gitignore-source, crate2nix, pkgs, darwin, lib, stdenv }:

(import ./Cargo.nix { inherit pkgs; }).rootCrate.build.overrideAttrs
  (prev: {
    src = gitignore-source.lib.gitignoreSource ./.;
    buildInputs = prev.buildInputs ++ [ crate2nix ];

    nativeBuildInputs = prev.nativeBuildInputs ++ lib.optionals
      stdenv.isDarwin [
      darwin.apple_sdk.frameworks.Security
    ];

    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  })
