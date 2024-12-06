# python.nix
{ pkgs, pythonVersion, extraPackages ? [ ], isVenv ? false }:

let
  pythonPkg = builtins.getAttr pythonVersion pkgs;
  pythonEnv =
    pythonPkg.withPackages (pythonPkgs: with pythonPkgs; extraPackages);
  hooks = import ./hooks.nix {
    inherit pkgs;
    lib-path = with pkgs; lib.makeLibraryPath [ libffi openssl stdenv.cc.cc ];
    pythonEnv = builtins.getAttr pythonVersion pkgs;
  };
  suffix = if isVenv then "-venv" else "";
in pkgs.mkShell {
  name = "python-${pythonVersion}${suffix}";
  packages = [ pkgs.bashInteractive ];
  buildInputs = with pkgs; [ pythonEnv ];
  shellHook = if isVenv then
    hooks.libPathHook + hooks.venvHook + hooks.envRequirementsHook
  else
    hooks.libPathHook;
}

