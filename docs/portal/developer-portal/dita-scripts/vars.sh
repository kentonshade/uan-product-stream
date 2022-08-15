#!/bin/bash

set -x

# Return value of pubsnumber and assign to var
echo "return value of pubsnumber and assign to var"
dataValues=$(xmllint --xpath '/map/topicmeta/data/@value' docs/portal/developer-portal/uan_admin.ditamap)
echo "data tag values are equal to ${dataValues}"
Edition=$(echo ${dataValues} | grep -o  [[:digit:]].[[:digit:]].[[:digit:]])
pubsnumber=$(xmllint --xpath 'string(/map/topicmeta/data/@value)' docs/portal/developer-portal/uan_admin.ditamap)
doctitle=$(xmllint --xpath 'string(/map/title)' docs/portal/developer-portal/uan_admin.ditamap)
export EDITION="${Edition}"
export PUBSNUMBER="${pubsnumber}"
export DOCTITLE="${doctitle}"

# We may have to create a groovy file for this:
# if [[ "${CI}" = "true" ]]; then
# echo "env.PRODUCT_VERSION=\"${PRODUCT_VERSION}\"" >> "${WORKSPACE}"/dac-assets/vars.groovy
# echo "env.PRODUCT_LABEL=\"${PRODUCT_LABEL}\"" >> "${WORKSPACE}"/dac-assets/vars.groovy
# echo "${PRODUCT_VERSION}" > "${WORKSPACE}"/dac-assets/product_version
# echo "${PRODUCT_LABEL}" > "${WORKSPACE}"/dac-assets/product_label
# fi