{ ... }:

{
  # Input-only provider: exposes `inputs.nur` for other modules' outputs to consume.
  # Loading `inputs.nur.modules.nixos.default` — which applies NUR's overlay and
  # puts `pkgs.nur.repos.*` (unvetted community code) into the global package set —
  # is the consumer's decision. Today the only consumer is apps#helium.
  inputs.nur = {
    override = true;
    url = "github:nix-community/nur";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  meta.name = "nur";
}
