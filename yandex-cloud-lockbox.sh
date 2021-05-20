function exportVarsFromSecret() {
    secretsId=$1

    # Request IAM token
    echo "> Fetching secrets with id ${secretsId}..."
    token=`curl -H Metadata-Flavor:Google http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | jq -r .access_token`

    # Request secret
    secret=`curl -X GET -H "Authorization: Bearer ${token}" \
https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/${secretsId}/payload`

    # Parse secret and build string like "export KEY1=VALUE1\nexport KEY2=VALUE2"
    echo "> Parsing secrets..."
    exportScript=`echo $secret | jq -r '.entries | map("export " + .key + "=\"" + .textValue + "\"") | join("\n")'`
    keysList=`echo $secret | jq -r '.entries | map("- " + .key) | join("\n")'`

    echo "> Exporting secret values to environment variables..."
    eval "${exportScript}"

    secretVarsCount=`echo -n "${exportScript}" | grep -c '^'`
    echo "${secretVarsCount} variables exported"
    echo "${keysList}"
}
