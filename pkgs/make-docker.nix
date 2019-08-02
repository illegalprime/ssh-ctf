{ dockerTools, runCommand, writeScript, lib
, bashInteractive, coreutils, less }:
{ name
, tag ? null
, contents ? []
, chdir ? "/ctf"
, cmd ? null
, prompt ? null
, banner ? null
, extra-bashrc ? ""
, ...
} @ args:

let
  nullOr = term: default: if isNull term then default else term;

  env = runCommand "${name}-usr-bin-env" {} ''
    mkdir -p $out/usr/bin
    ln -s ${coreutils}/bin/coreutils $out/usr/bin/env
  '';

  bashrc-file = writeScript "${name}-bashrc-file" ''
    ${nullOr prompt ''
      # Provide a nice prompt.
      PROMPT_COLOR="1;31m"
      let $UID && PROMPT_COLOR="1;32m"
      PS1="\[\033[$PROMPT_COLOR\][${name}:\w]\\$\[\033[0m\] "
    ''}
    echo
    echo ${lib.strings.escapeShellArg banner}
    ${extra-bashrc}
  '';

  bashrc = runCommand "${name}-bashrc" {} ''
    mkdir -p $out/etc
    cat ${bashrc-file} > $out/etc/bashrc
  '';
in
dockerTools.buildImage (lib.recursiveUpdate {
  inherit name;
  tag = nullOr tag "latest";

  contents = [
    bashrc
    bashInteractive
    coreutils
    less
    env
  ] ++ contents;

  config = {
    Cmd = nullOr cmd [ "/bin/bash" ];
    WorkingDir = nullOr chdir "/";
  };
} (removeAttrs args
  ["cmd" "chdir" "contents" "tag" "name" "prompt" "banner" "extra-bashrc"]))
