{ ... }:

{
  inputs.jovian = {
    override = true;
    url = "github:jovian-experiments/jovian-nixos";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  meta.name = "jovian";
}
