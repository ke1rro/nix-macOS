{
  description = "Isolated C++ dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

        # macOS-specific packages
        darwinPackages = if pkgs.stdenv.isDarwin then [
          # Ensure proper compiler toolchain on macOS
          pkgs.darwin.apple_sdk.frameworks.CoreFoundation
          pkgs.darwin.apple_sdk.frameworks.CoreServices
          pkgs.darwin.cctools
        ] else [];

      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Core C++ toolchain
            clang
            clang-tools  # includes clangd, clang-tidy, etc.
            cmake
            ninja
            gnumake

            # Libraries
            boost
            catch2
            fmt
            nlohmann_json

            # Build/Debug tools
            gdb
            lldb
            valgrind

            # LSP and formatting
            ccls
            clang-format

            # Build system generators
            pkg-config
            meson
          ] ++ darwinPackages;

          shellHook = ''
            echo "🚀 C++ development environment loaded!"
            echo "C++ Compiler: $(clang --version | head -n 1)"
            echo "CMake: $(cmake --version | head -n 1)"
            export CPATH=$CPATH:${pkgs.boost.dev}/include
            export LIBRARY_PATH=$LIBRARY_PATH:${pkgs.boost.out}/lib

            # Create compile_commands.json symlink if not found
            if [ -f ./build/compile_commands.json ] && [ ! -f ./compile_commands.json ]; then
              ln -sf ./build/compile_commands.json .
            fi
          '';
        };
      });
}
