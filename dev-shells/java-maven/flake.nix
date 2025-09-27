{
  description = "Isolated Java/Maven dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:

    let
      mkJavaShell = system:
        let pkgs = import nixpkgs { inherit system; };
        in pkgs.mkShell {
          buildInputs = [
            pkgs.zsh
            pkgs.openjdk21
            pkgs.maven
          ];

          shellHook = ''
            echo "🚀 Java/Maven dev shell ready on ${system}!"
            echo "Java: $(java -version 2>&1 | head -n 1)"
            echo "Maven: $(mvn -version 2>&1 | head -n 1)"
            exec zsh
          '';
        };
    in
    {
      devShells = {
        "aarch64-darwin" = {
          default = mkJavaShell "aarch64-darwin";
        };
        "x86_64-darwin" = {
          default = mkJavaShell "x86_64-darwin";
        };
        "x86_64-linux" = {
          default = mkJavaShell "x86_64-linux";
        };
        "aarch64-linux" = {
          default = mkJavaShell "aarch64-linux";
        };
      };
    };
}
