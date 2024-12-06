{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "jdk-21";

  buildInputs = [
    pkgs.jdk21 # Java 21 JDK
    pkgs.gradle # Gradle build tool
    pkgs.lombok # Lombok annotation processor
  ];

  # Optionally set environment variables to improve the dev experience
  shellHook = ''
    export JAVA_HOME=${pkgs.jdk21}/lib/openjdk
    export PATH=${pkgs.gradle}/bin:$PATH
    echo "Java development environment with Gradle and Lombok is active!"
  '';
}
