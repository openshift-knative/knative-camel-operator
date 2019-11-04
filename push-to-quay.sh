#!/bin/bash

PACKAGE=knative-camel-operator
VERSION=0.9.0

export AUTH_TOKEN=$(curl -sH "Content-Type: application/json" -XPOST https://quay.io/cnr/api/v1/users/login -d '{"user": {"username": "'"${QUAY_USERNAME}"'", "password": "'"${QUAY_PASSWORD}"'"}}' | jq -r '.token')

operator-courier --verbose push deploy/olm-catalog/${PACKAGE}/ ${QUAY_USERNAME} ${PACKAGE} ${VERSION} "$AUTH_TOKEN"
