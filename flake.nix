{
  inputs.nixpkgs.url = "nixpkgs/f45667df53b4a4bb7b0bc0fa4fb83e8c0c51add5";
  # https://pdos.csail.mit.edu/6.1810/
  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      crossPkgs = (
        import pkgs {
          # uses GCC and newlib
          crossSystem = {
            system = "riscv64-none-elf";
          };
        }
      );
    in
    {
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
      devShell.x86_64-linux = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          qemu_full
          gnumake
          crossPkgs.gcc
        ];
      };
    };
}
