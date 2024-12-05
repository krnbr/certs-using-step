{
    "subject": {
        "commonName": {{toJson .Subject.CommonName }}
    },
    "sans": {{ toJson .SANs }},
    "keyUsage": ["digitalSignature", "keyEncipherment", "keyAgreement"],
    "extKeyUsage": ["serverAuth"]
}