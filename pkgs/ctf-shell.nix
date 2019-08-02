{ docker, writeShellScriptBin }:
{ name, level }:

(writeShellScriptBin "ctf-shell_${name}" ''
  trap exit INT TERM STOP EXIT

  exec ${docker}/bin/docker run \
    -it \
    ${level.image.imageName}:${level.image.imageTag}

  exit
'') // {
  shellPath = "/bin/ctf-shell_${name}";
}
