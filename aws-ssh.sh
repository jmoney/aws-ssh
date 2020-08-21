#!/bin/bash

REGION="us-east-1"
PROFILE="dev-poweruser"
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --region)
            REGION="$2"
            shift # past argument
            shift # past value
        ;;
        --profile)
            PROFILE="$2"
            shift # past argument
            shift # past value
        ;;
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
        ;;
    esac
done

ssh -o "User=ec2-user" \
    -o "ProxyCommand=aws --region ${REGION} --profile ${PROFILE} ssm start-session --target %h --document-name AWS-StartSSHSession --parameters portNumber=%p" \
    -o "StrictHostKeyChecking=no" \
    ${POSITIONAL[@]}

