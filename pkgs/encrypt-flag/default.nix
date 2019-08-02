{ runCommand, writeText, openssl }:
{ key ? null, key-file ? null, flag }:

runCommand "encrypt-flag" {} ''
  mkdir -p $out/ctf
  mkdir -p $out/bin

  ${openssl}/bin/openssl \
    enc \
    -aes-256-cbc \
    -salt \
    ${if isNull key-file then "-k ${key}" else "-kfile ${key-file}"} \
    -in ${flag} \
    -out $out/ctf/flag.enc

  substitute ${./decrypt.sh} decrypt.sh  \
    --replace openssl ${openssl}/bin/openssl
  install -m 0755 decrypt.sh $out/bin/decrypt

  cp ${./HOW_TO_DECRYPT_FLAG.txt} $out/ctf/HOW_TO_DECRYPT_FLAG.txt
''
