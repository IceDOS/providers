# AGENTS.md — IceDOS **providers**

> Utilizes the **IceDOS** framework. The full bible — module structure, config flow,
> the `icedos rebuild --build` test loop, `validate.*` helpers, dep loading — lives in
> **core**: <https://github.com/IceDOS/core/blob/main/AGENTS.md> — this file only
> covers what is specific to **providers**.

## Non-negotiable rules (full detail in core)
- Build/test only via the `icedos` CLI — **never `sudo nixos-rebuild`**.
- **Never** `git commit/stash/reset/pull` — the user manages git.
- Every option uses a `validate.*`/`mk*Option` helper; **no untyped options**.
- A module's `config.toml` defaults must mirror its `icedos.nix` defaults.
- Format with `icedos nixf .` after editing any `.nix`.
- If a repo or the config root you need isn't checked out locally, **ask the user** for
  its path or permission to `git clone` it — don't guess or clone unprompted.

## Purpose
Extra package/source providers — flake `inputs` for upstream Nix sources that other
repos' modules build on top of. Nothing here applies `nixpkgs.overlays` or loads NixOS
modules itself; consumers decide what to load.

## Layout
`modules/{jovian,nur}/icedos.nix` (no `config.toml` — these modules declare no
options); `flake.nix` exposes them via
`icedosLib.scanModules { path = ./modules; filename = "icedos.nix"; }`.

## Module shape here
Input-only provider modules. Each declares a single `inputs.<name>` flake input
(`override = true`, so the generated state flake carries it under the stable name
`<name>`), which is then visible to every enabled module's `outputs.nixosModules`
under that name. Loading the upstream's own NixOS module / overlay is the consumer's
decision.

## Test a change to this repo
This repo is only pulled via consumers' `meta.dependencies`, so it has no entry in the
config root's `config.toml`. To test a local checkout, add a gitignored
`configs/.local.toml` in the config root:

```toml
[[icedos.repositories]]
url = "github:icedos/providers"
overrideUrl = "path:/abs/path/to/providers"
modules = ["nur"]
```

then `icedos rebuild --build` (no activation). Before the build, back up
`config/.state/flake.lock` — the override rewrites this repo's lock node — and after
the build delete `.local.toml` and restore the lock (or `git restore config/.state/flake.lock`).

## Notable modules / gotchas
- `nur` — input-only. The NUR overlay (`inputs.nur.modules.nixos.default`) is applied
  by the consumer that needs it — today `apps#helium`. Trust boundary: once applied it
  puts `pkgs.nur.repos.*` (unvetted community code) into the global package set. A
  future module that wants NUR must depend on `providers#nur` **and** load the overlay
  itself — never silently rely on helium.
- `jovian` — input-only. Exposes `inputs.jovian` (Jovian-NixOS, Steam Deck /
  SteamOS-style); do not load `jovian.nixosModules.default` here by default (it sets
  `allowUnfree = true` and SteamOS services). Consumers: `hardware#steamdeck`,
  `apps#steam` (`os-session`, `sunshine-headless-session`), `kde#foreground-booster`.
- A module's declared input name is visible to all enabled modules under that name;
  `override` only controls the top-level flake input name. Two modules declaring the
  same input name collide in the masked input set regardless of `override`.
