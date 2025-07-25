{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    jdk21 # or jdk8, jdk17 as needed
    gradle # or maven
  ];

  shellHook = ''
    export JAVA_HOME="${pkgs.jdk21}/lib/openjdk"
    echo "JDK 21 environment loaded."
    java -version
  '';
}