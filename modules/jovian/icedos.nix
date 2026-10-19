{ ... }:

{
  # Input-only provider: exposes `inputs.jovian` for consumer modules.
  # Do NOT load nixosModules.default here (sets allowUnfree + SteamOS services).
  inputs.jovian = {
    url = "github:jovian-experiments/jovian-nixos";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Lib contributions get no pkgs or inputs, so callers pass both.
  lib.jovian = rec {
    # Applies the overlay directly; pkgs.extend would re-evaluate nixpkgs.
    packages = { inputs, pkgs }: (inputs.jovian.overlays.default pkgs pkgs).jovianPackages;
    getPackage = args: name: (packages args).${name};
    getPackages = args: names: map (getPackage args) names;
  };

  outputs.nixosModules =
    { ... }:
    [
      {
        icedos.system.tips.list = [
          "Steam Deck hardware support and the console-style Steam session come from Jovian."
          "Modules that need Jovian pull it in on their own, so there is nothing to turn on."
        ];
      }
    ];

  meta.name = "jovian";
}
