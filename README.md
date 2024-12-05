This one is for easily setting up the certificates using the STEP CLI.

This involves setting up root CA, intermediate CA, server cert, client cert.

- intermediate CA can be skipped if someone does not need it.

STEP 0 - Setup [organization.json](/organization.json) based on your requirements, that will store common properties like country, state, organization, etc.

STEP 1 - Create Root CA

```bash
step certificate create --insecure --no-password \
    --kty=EC --crv=P-384 --set-file organization.json \
    --not-after=87660h \
    --template root.tpl \
    "Localhost's Root CA" \
    root_ca.crt root_ca.key
```

STEP 2 - Create Intermediate CA

```bash
step certificate create --insecure --no-password \
    --kty=EC --crv=P-384 \
    --set-file organization.json \
    --ca root_ca.crt --ca-key root_ca.key \
    --not-after=87660h \
    --template intermediate.tpl \
    "Localhost's Intermediate CA" \
    intermediate_ca.crt intermediate_ca.key
```

STEP 3 - Create Leaf Server cert

```bash
step certificate create --insecure --no-password \
   --kty=EC --crv=P-384 \
   --set-file organization.json \
   --set "organizationUnit=Localhost’s Certificate" \
   --ca intermediate_ca.crt --ca-key intermediate_ca.key \
   --not-after=8766h \
   --template leaf-server.tpl \
   "localhost" \
   localhost.crt localhost.key
```

STEP 4 - Create Leaf Client cert

```bash
step certificate create --insecure --no-password \
   --kty=EC --crv=P-384 \
   --set-file organization.json \
   --set "organizationUnit=Localhost’s Certificate" \
   --ca intermediate_ca.crt --ca-key intermediate_ca.key \
   --not-after=8766h \
   --template leaf-client.tpl \
   "Localhost-Client-Certificate" client.crt client.key
```

STEP 5 - Create p12 bundle (same can be done for server and client cert)

```bash
step certificate p12 client_cert.p12 \
   client.crt client.key --ca intermediate_ca.crt --no-password --insecure --legacy
```

STEP 6 - base64 encode the p12 bundle

```bash
cat client_cert.12 | step base64
```

STEP 7 - install root certificate in the system's trust store, it will prompt for credentials

```bash
step certificate install root_ca.crt --all
```

STEP 8 - concat the intermediate cert & server's cert into a single file

```bash
cat localhost.crt intermediate_ca.crt > bundle.crt
```

