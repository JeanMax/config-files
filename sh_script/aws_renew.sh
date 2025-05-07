#!/usr/bin/bash
set -eu
current_key="$(aws configure get aws_access_key_id)"
create_json="$(aws iam create-access-key)"

new_key="$(jq -r '.AccessKey.AccessKeyId' <<< "${create_json}")"
new_secret="$(jq -r '.AccessKey.SecretAccessKey' <<< "${create_json}")"

aws configure set aws_access_key_id "${new_key}"
aws configure set aws_secret_access_key "${new_secret}"

echo "Created key ${new_key}, waiting for AWS to accept new token"
sleep 6  # Wait that new token is accepted by AWS

loop=0
while ! aws iam delete-access-key --access-key-id "${current_key}"
do
    let "loop += 1"
    if [ $loop -gt 5 ]
    then
        echo "Failed to delete old key, bailing out."
        echo "Please issue command manually:"
        echo "aws iam delete-access-key --access-key-id ${current_key}"
        break
    fi
    echo "Deletion of ${current_key} failed, retrying in 2 seconds"
    sleep 2
done

echo "Successfully replaced ${current_key} with ${new_key}"
