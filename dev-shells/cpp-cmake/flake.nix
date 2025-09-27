{
  description = "Isolated C++ dev environment with GCC";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:

    let
      mkCppShell = system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              allowBroken = true;
            };
          };
        in
        pkgs.mkShell {
          buildInputs = with pkgs; [
            gcc
            gnumake
            cmake
            ninja

            # Libraries
            boost
            catch2
            fmt
            nlohmann_json

            # Debug tools
            gdb
            lldb

            # LSP / tooling
            ccls
            pkg-config
            meson
          ];

          shellHook = ''
            echo "🚀 C++ development environment loaded on ${system} with GCC!"
            echo "GCC: $(gcc --version | head -n1)"
            echo "CMake: $(cmake --version | head -n1)"

            # Force GCC as default compiler
            export CC=$(which gcc)
            export CXX=$(which g++)
            export CPATH=$CPATH:${pkgs.boost.dev}/include
            export LIBRARY_PATH=$LIBRARY_PATH:${pkgs.boost.out}/lib

            if [ -f ./build/compile_commands.json ] && [ ! -f ./compile_commands.json ]; then
              ln -sf ./build/compile_commands.json .
            fi
          '';
        };
    in
    {
      devShells = {
        "aarch64-darwin" = { default = mkCppShell "aarch64-darwin"; };
        "x86_64-darwin" = { default = mkCppShell "x86_64-darwin"; };
        "x86_64-linux" = { default = mkCppShell "x86_64-linux"; };
        "aarch64-linux" = { default = mkCppShell "aarch64-linux"; };
      };
    };
}
