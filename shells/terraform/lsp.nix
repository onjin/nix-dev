{ pkgsUnfree ? import <nixpkgs> { } }:
pkgsUnfree.mkShell {
  name = "terraform-lsp";
  buildInputs = with pkgsUnfree; [ terraform terraform-lsp ];
}
