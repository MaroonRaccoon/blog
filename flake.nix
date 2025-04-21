{
  description = "blog";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
          inherit system;
      };
      node = pkgs.nodePackages_latest;
      buildInputs = with pkgs; [
        node.mathjax
        python3Packages.python
        vscode-langservers-extracted
      ];
    in
    {
      defaultPackage.${system} = pkgs.stdenv.mkDerivation {
        name = "blog";
        inherit buildInputs;
        src = ./.;
      };

      devShell.${system} = pkgs.mkShell {
        inherit buildInputs;
      };
    };
}
