{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "jdk-23";

  buildInputs = [
    pkgs.jdk23                # Java 23 JDK
    pkgs.gradle               # Gradle build tool
    pkgs.lombok               # Lombok annotation processor
  ];

  # Optionally set environment variables to improve the dev experience
  shellHook = ''
    export JAVA_HOME=${pkgs.jdk23}/lib/openjdk
    export PATH=${pkgs.gradle}/bin:$PATH
    echo "Java development environment with Gradle and Lombok is active!"
  '';
}
