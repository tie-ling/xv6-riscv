{
  inputs.nixpkgs.url = "nixpkgs/f45667df53b4a4bb7b0bc0fa4fb83e8c0c51add5";
  # https://pdos.csail.mit.edu/6.1810/
  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      crossPkgs = (
        import nixpkgs {
          localSystem = "x86_64-linux";
          # uses GCC and newlib
          crossSystem = {
            system = "riscv64-none-elf";
          };
        }
      );
    in
    {
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
      devShell.x86_64-linux = crossPkgs.mkShell {
        nativeBuildInputs = with pkgs; [ gnumake qemu_full ];
      };
    };
}
