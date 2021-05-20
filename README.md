# yandex-cloud-lockbox
Bash script that helps you to work with Yandex.Cloud Lockbox service.

## Requirements
- `curl`
- `jq`

## Functions
### exportVarsFromSecret
Fetches secret from Yandex.Cloud Lockbox service and exports its values to environment variables. It supposed to be ran on VM (e.g. when your Docker container starts).

Make sure your service account has roles
- `iam.serviceAccounts.tokenCreator`
- `lockbox.payloadViewer`
- `kms.keys.encrypterDecrypter` (if your secret encrypted by KMS key)

#### Usage
```bash
# Include library
. ./yandex-cloud-lockbox.sh

# Run function
exportVarsFromSecret your-secret-id

# Use your variables
echo $VAR_FROM_SECRET
```