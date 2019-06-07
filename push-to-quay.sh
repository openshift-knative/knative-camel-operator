#!/bin/bash

export AUTH_TOKEN=$(curl -sH "Content-Type: application/json" -XPOST https://quay.io/cnr/api/v1/users/login -d '{"user": {"username": "'"${QUAY_USERNAME}"'", "password": "'"${QUAY_PASSWORD}"'"}}' | jq -r '.token')

operator-courier --verbose push deploy/olm-catalog/knative-camel-operator/ ${QUAY_USERNAME} knative-camel-operator 0.6.0 "$AUTH_TOKEN"
