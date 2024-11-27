{ pkgsUnfree ? import <nixpkgs> { } }:
pkgsUnfree.mkShell {
  name = "terraform";
  buildInputs = with pkgsUnfree; [ terraform ];
}
