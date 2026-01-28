openssl ecparam -genkey -name secp384r1 | openssl ec -aes256 -out rootCA.key
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 3650 -out rootCA.crt -subj "/CN=Home CA Root" -addext "keyUsage = critical, keyCertSign"  -addext "basicConstraints = critical, CA:TRUE, pathlen:0"  -addext "subjectKeyIdentifier = hash"
openssl genrsa -out ${domain}.key 2048

openssl req -sha256 -new -key ${domain}.key -out ${domain}.csr -subj "/CN=*.${domain}/O=Home/OU=srivatsan@raptor (Srivatsan Iyer)" -reqexts SAN -config <(echo "[SAN]\nsubjectAltName=DNS:${domain},DNS:*.${domain}\n")

openssl x509 -req -sha256 -in "${domain}.csr" -out "${domain}.crt" -days 731 \
  -CAkey "rootCA.key" -CA "rootCA.crt" -CAcreateserial -extfile <(cat <<END
    subjectAltName = DNS:${domain},DNS:*.${domain}
    keyUsage = critical, digitalSignature, keyEncipherment
    extendedKeyUsage = serverAuth
    basicConstraints = CA:FALSE
    authorityKeyIdentifier = keyid:always
    subjectKeyIdentifier = none
END
)
