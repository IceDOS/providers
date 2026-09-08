{ ... }:

{
  # Input-only provider: exposes `inputs.nur` for consumer modules.
  # Do NOT load nixosModules.default here (unvetted community repos go global).
  inputs.nur = {
    url = "github:nix-community/nur";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs.nixosModules =
    { ... }:
    [
      {
        icedos.system.tips.list = [
          "Some apps here are packaged by the community instead of the main package set."
          "Community packages are not reviewed, so keep only the modules you actually use."
          "Community-packaged apps update with the rest of your system on every rebuild."
        ];
      }
    ];

  meta.name = "nur";
}
