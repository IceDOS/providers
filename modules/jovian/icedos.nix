{ ... }:

{
  inputs.jovian = {
    override = true;
    follows = "chaotic/jovian";
  };

  outputs.nixosModules =
    { inputs, ... }:
    [
      inputs.jovian.nixosModules.default
    ];

  meta.name = "jovian";
}
