{ pkgs ? import <nixpkgs> {} }:

{
  neurolink = pkgs.callPackage ./hosts/neurolink {};
}

# deployment = {
#   buildOnTarget = true;
#   deployment.targetHost = "neurolink.bee-liberty.ts.net";
# };
