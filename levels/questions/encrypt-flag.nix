{ runCommand, writeText, ctf-flag-format, openssl
, key, flag }:

runCommand "encrypt-flag" {} ''
  mkdir -p $out/ctf
  mkdir -p $out/bin

  ${openssl}/bin/openssl \
    enc \
    -aes-256-cbc \
    -salt \
    -k ${key} \
    -in ${ctf-flag-format flag} \
    -out $out/ctf/flag.enc

  substitute ${./decrypt.sh} decrypt.sh  \
    --replace openssl ${openssl}/bin/openssl
  install -m 0755 decrypt.sh $out/bin/decrypt
''
