{ lib, runCommand, flag }:
with lib;
let
  treeify = list: if list == [] then [] else let
    rest = tail list;
    len = length rest;
    half = len / 2;
  in [
    (head list)
    (treeify (sublist 0 half rest))
    (treeify (sublist half (len - half) rest))
  ];

  flag-tree = treeify (stringToCharacters flag);
in
{
  inherit treeify all_paths;
  # TODO: not done at all
}
