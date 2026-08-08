{ ... }:

{
  # Input-only provider: exposes `inputs.jovian` for other modules' outputs
  # to consume. Do NOT load `inputs.jovian.nixosModules.default` here by default — it
  # sets `allowUnfree = true` and enables SteamOS services; consumers opt in. Today:
  # hardware#steamdeck, apps#steam (os-session, sunshine-headless-session),
  # kde#foreground-booster.
  # The input is namespaced to its declaring module — top-level flake name
  # `icedos-github_icedos_providers-jovian-jovian` — and exposed to every enabled
  # module's `outputs.nixosModules` under the bare name `jovian`. Consumers needing
  # the top-level name in a string context (e.g. `follows`) compute it via
  # `icedosLib.moduleInputName { repo = "github:icedos/providers"; module = "jovian"; input = "jovian"; }`.
  inputs.jovian = {
    url = "github:jovian-experiments/jovian-nixos";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  meta.name = "jovian";
}
