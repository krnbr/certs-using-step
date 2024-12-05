{
    "subject": {
        "country": {{ toJson .Insecure.User.country }},
        "organization": {{ toJson .Insecure.User.organization }},
        "organizationalUnit": {{ toJson .Insecure.User.organizationUnit }},
        "province": {{ toJson .Insecure.User.province }},
        "locality": {{ toJson .Insecure.User.locality }},
        "commonName": {{toJson .Subject.CommonName }}
    },
    "sans": [{"type": "email", "value": "email@live.in"}],
    "keyUsage": ["digitalSignature", "keyEncipherment"],
    "extKeyUsage": ["clientAuth"]
}