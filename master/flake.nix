{
  description = ''A library for managing your CouchDB. Easy & comfortably to use.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-couchdb-master.flake = false;
  inputs.src-couchdb-master.owner = "theAkito";
  inputs.src-couchdb-master.ref   = "refs/heads/master";
  inputs.src-couchdb-master.repo  = "nim-couchdb";
  inputs.src-couchdb-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-couchdb-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-couchdb-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}