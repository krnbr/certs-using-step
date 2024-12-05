{
	"subject": {
        "country": {{ toJson .Insecure.User.country }},
        "organization": {{ toJson .Insecure.User.organization }},
        "organizationalUnit": {{ toJson .Insecure.User.organizationUnit }},
        "province": {{ toJson .Insecure.User.province }},
        "locality": {{ toJson .Insecure.User.locality }},
        "commonName": {{toJson .Subject.CommonName }}
    },
	"issuer": {{ toJson .Subject }},
	"keyUsage": ["certSign", "crlSign"],
	"basicConstraints": {
		"isCA": true,
		"maxPathLen": 1
	}
}