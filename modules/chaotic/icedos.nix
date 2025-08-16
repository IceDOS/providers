{ ... }:

{
  inputs = {
    chaotic = {
      override = true;
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };

    home-manager = {
      override = true;
      follows = "chaotic/home-manager";
    };

    nixpkgs = {
      override = true;
      follows = "chaotic/nixpkgs";
    };
  };

  outputs.nixosModules =
    { inputs, ... }:
    [
      inputs.chaotic.nixosModules.default
    ];

  meta.name = "chaotic";
}
