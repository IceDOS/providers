{ ... }:

{
  inputs.jovian = {
    override = true;
    url = "github:jovian-experiments/jovian-nixos";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs.nixosModules =
    { inputs, ... }:
    [
      inputs.jovian.nixosModules.default
    ];

  meta.name = "jovian";
}
