#!/bin/bash

export AUTH_TOKEN=$(curl -sH "Content-Type: application/json" -XPOST https://quay.io/cnr/api/v1/users/login -d '{"user": {"username": "'"${QUAY_USERNAME}"'", "password": "'"${QUAY_PASSWORD}"'"}}' | jq -r '.token')

operator-courier --verbose push manifests/knative-camel/ ${QUAY_USERNAME} knative-camel 0.6.0 "$AUTH_TOKEN"
