# aws-creds-export

[![Build Status](https://travis-ci.com/nclsprsn/aws-creds-export.svg?branch=master)](https://travis-ci.com/nclsprsn/aws-creds-export)

Automates the process of obtaining temporary credentials from the AWS Security Token Service and export the AWS API keys.

## Requirements

- [aws-cli](https://aws.amazon.com/fr/cli/)
- [python3](https://www.python.org/)
- [aws-mfa](https://github.com/broamski/aws-mfa)

## Usage

```sh
source aws-creds-export.sh --profile PROFILE_NAME
```
