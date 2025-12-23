{ ... }:

{
  inputs.nur = {
    override = true;
    url = "github:nix-community/nur";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs.nixosModules =
    { inputs, ... }:
    [
      inputs.nur.modules.nixos.default
    ];

  meta.name = "nur";
}
