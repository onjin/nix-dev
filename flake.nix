{
  description = "Onjin's Nix flake templates";

  outputs = { self }: {
    templates = {
      python-shell = {
        path = ./python/shell;
        description = "Python shell flake";
      };
    };
  };
}
