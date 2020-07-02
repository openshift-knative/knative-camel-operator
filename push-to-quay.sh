#!/bin/bash

set -o pipefail
set -eu

location=$(dirname $0)



PACKAGE=knative-camel-operator-dev
BASE_VERSION=0.15.0


update_manifest() {
    local version=$1

    local manifest_dir=$location/deploy/olm-catalog/knative-camel-operator-dev
    echo "Renaming manifest dir"
    old_version=""
    for dir in $manifest_dir/*/; do
      dir=${dir%*/}
      current=$(basename $dir)
      if [ "$current" != "$version" ]; then
        old_version=$current
        mv $dir $manifest_dir/$version
      fi
    done

    echo "Old version was $old_version"

    echo "Updating Manifest"
    sed -i "s/^  version\: .*$/  version: $version/" $location/deploy/olm-catalog/knative-camel-operator-dev/$version/knative-camel-operator.clusterserviceversion.yaml
    sed -i "s/^  replaces\: .*$/  replaces: knative-camel-operator.v$old_version/" $location/deploy/olm-catalog/knative-camel-operator-dev/$version/knative-camel-operator.clusterserviceversion.yaml
    sed -i "s/^\(.*\)name\: knative-camel-operator\.v.*$/\1name: knative-camel-operator.v$version/" $location/deploy/olm-catalog/knative-camel-operator-dev/$version/knative-camel-operator.clusterserviceversion.yaml
    sed -i "s/^\(.*\)currentCSV\: knative-camel-operator\.v.*$/\1currentCSV: knative-camel-operator.v$version/" $location/deploy/olm-catalog/knative-camel-operator-dev/knative-camel-operator.package.yaml

}


new_version=$BASE_VERSION-$(date '+%Y%m%d%H%M%S')
update_manifest $new_version


export AUTH_TOKEN=$(curl -sH "Content-Type: application/json" -XPOST https://quay.io/cnr/api/v1/users/login -d '{"user": {"username": "'"${QUAY_USERNAME}"'", "password": "'"${QUAY_PASSWORD}"'"}}' | jq -r '.token')

operator-courier --verbose push deploy/olm-catalog/${PACKAGE}/ ${QUAY_USERNAME} ${PACKAGE} ${new_version} "$AUTH_TOKEN"
