{ ... }:

{
  # Input-only provider: exists to expose `inputs.jovian` for other modules' outputs
  # to consume. Do NOT load `inputs.jovian.nixosModules.default` here by default — it
  # sets `allowUnfree = true` and enables SteamOS services; consumers opt in. Today:
  # hardware#steamdeck, apps#steam (os-session, sunshine-headless-session),
  # kde#foreground-booster.
  inputs.jovian = {
    override = true;
    url = "github:jovian-experiments/jovian-nixos";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  meta.name = "jovian";
}
