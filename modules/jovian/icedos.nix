{ ... }:

{
  # Input-only provider: exposes `inputs.jovian` for consumer modules.
  # Do NOT load nixosModules.default here (sets allowUnfree + SteamOS services).
  inputs.jovian = {
    url = "github:jovian-experiments/jovian-nixos";
    inputs.nixpkgs.follows = "nixpkgs";
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
