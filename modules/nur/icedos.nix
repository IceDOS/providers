{ ... }:

{
  # Input-only provider: exposes `inputs.nur` for other modules' outputs to consume.
  # Loading `inputs.nur.modules.nixos.default` — which applies NUR's overlay and
  # puts `pkgs.nur.repos.*` (unvetted community code) into the global package set —
  # is the consumer's decision. Today the only consumer is apps#helium.
  # The input is namespaced to its declaring module — top-level flake name
  # `icedos-github_icedos_providers-nur-nur` — and exposed to every enabled module's
  # `outputs.nixosModules` under the bare name `nur`. Consumers needing the top-level
  # name in a string context compute it via `icedosLib.moduleInputName`.
  inputs.nur = {
    url = "github:nix-community/nur";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  meta.name = "nur";
}
