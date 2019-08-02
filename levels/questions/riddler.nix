{ runCommand }:

runCommand "riddler" {} ''
  mkdir -p $out/bin/
  install -m 0755 ${./riddler.sh} $out/bin/riddler
''

