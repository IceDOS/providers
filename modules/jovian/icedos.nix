{ ... }:

{
  # Input-only provider: exposes `inputs.jovian` for consumer modules.
  # Do NOT load nixosModules.default here (sets allowUnfree + SteamOS services).
  inputs.jovian = {
    url = "github:jovian-experiments/jovian-nixos";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  meta.name = "jovian";
}
