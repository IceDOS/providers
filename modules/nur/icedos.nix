{ ... }:

{
  # Input-only provider: exposes `inputs.nur` for consumer modules.
  # Do NOT load nixosModules.default here (unvetted community repos go global).
  inputs.nur = {
    url = "github:nix-community/nur";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  meta.name = "nur";
}
