{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "jdk-11";

  buildInputs = [
    pkgs.jdk11                # Java 11 JDK
    pkgs.gradle               # Gradle build tool
    pkgs.lombok               # Lombok annotation processor
  ];

  # Optionally set environment variables to improve the dev experience
  shellHook = ''
    export JAVA_HOME=${pkgs.jdk11}/lib/openjdk
    export PATH=${pkgs.gradle}/bin:$PATH
    echo "Java development environment with Gradle and Lombok is active!"
  '';
}
