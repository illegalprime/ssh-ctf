{ config, pkgs, lib, ... }:
let cfg = config.ctf.levels.hot-n-cold; in
let key = "yaf"; in
{
  ctf.levels.hot-n-cold.image = pkgs.ctf-make-docker {
    name = "hot-n-cold";

    contents = with pkgs; [
      (callPackage ./hot_or_cold { inherit (cfg) flag; inherit key; })
    ];

    banner = ''
      ┏━━
      ┇  Level ${toString cfg.number}: Hot & Cold
      ┇  Commands: ls, for, hot_or_cold
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';

    extra-bashrc = ''
      mkdir -p /ctf/tree/a
      pushd /ctf/tree/a >/dev/null

      ln -srf ../a .; ln -srf ../b .; ln -srf ../c .; ln -srf ../d .; ln -srf ../e .
      ln -srf ../f .; ln -srf ../g .; ln -srf ../h .; ln -srf ../i .; ln -srf ../j .
      ln -srf ../k .; ln -srf ../l .; ln -srf ../m .; ln -srf ../n .; ln -srf ../o .
      ln -srf ../p .; ln -srf ../q .; ln -srf ../r .; ln -srf ../s .; ln -srf ../t .
      ln -srf ../u .; ln -srf ../v .; ln -srf ../w .; ln -srf ../x .; ln -srf ../y .
      ln -srf ../z .
      cd ..

      cp -a a b; cp -a a c; cp -a a d; cp -a a e; cp -a a f;
      cp -a a g; cp -a a h; cp -a a i; cp -a a j; cp -a a k;
      cp -a a l; cp -a a m; cp -a a n; cp -a a o; cp -a a p;
      cp -a a q; cp -a a r; cp -a a s; cp -a a t; cp -a a u;
      cp -a a v; cp -a a w; cp -a a x; cp -a a y; cp -a a z;
      popd >/dev/null
    '';
  };
}
