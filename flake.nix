{
  description = ''A library for managing your CouchDB. Easy & comfortably to use.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."couchdb-master".dir   = "master";
  inputs."couchdb-master".owner = "nim-nix-pkgs";
  inputs."couchdb-master".ref   = "master";
  inputs."couchdb-master".repo  = "couchdb";
  inputs."couchdb-master".type  = "github";
  inputs."couchdb-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."couchdb-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}