#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "You must sourced the script with this command \"source aws-creds-export.sh --profile PROFILE_NAME\"."
  exit 1
fi

CONF_FILE=~/.aws/credentials

function usage {
  echo "Automates the process of obtaining temporary credentials from the "
  echo "AWS Security Token Service and export the AWS API keys."
  echo "Usage: $0 --profile <profile>"
}

# read parameters
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -h|--help)
      usage
      return 0
    ;;
    -p|--profile)
      PROFILE="$2"
      shift
    ;;
  esac
shift
done

if [ -z "$PROFILE" ]; then
  usage
  return 1
fi

aws-mfa --profile $PROFILE

if [ $? -ne 0  ]; then
  echo "Invalid authentication. Please try again."
  return 1
fi

export AWS_ACCESS_KEY_ID="$(aws configure get aws_access_key_id --profile $PROFILE)"
export AWS_SECRET_ACCESS_KEY="$(aws configure get aws_secret_access_key --profile $PROFILE)"
export AWS_SESSION_TOKEN="$(aws configure get aws_session_token --profile $PROFILE)"
export AWS_DEFAULT_REGION="$(aws configure get region --profile $PROFILE)"

echo "Profile: $PROFILE"
echo AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
echo AWS_SECRET_ACCESS_KEY=$(echo $AWS_SECRET_ACCESS_KEY|tr '[:print:]' '*')
echo AWS_SESSION_TOKEN=$(echo $AWS_SESSION_TOKEN|tr '[:print:]' '*')
echo AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
