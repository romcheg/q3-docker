#!/bin/bash

set -eu


# NOTE(romcheg): In order to have the same command syntax
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED="gsed"
else
    SED="sed"
fi

MAIN_BRANCH="${MAIN_BRANCH:-"master"}"
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
LATEST_TAG="$(git describe --abbrev=0)"
CURRENT_TAG="$(git describe)"


generate_next_version() {
    local current_dateversion="$(echo "${LATEST_TAG}" | cut -d '.' -f1)"
    local current_path_number=$(echo "${LATEST_TAG}" | cut -d '.' -f2)

    local new_dateversion=$(date +"%Y%m%d")

    if [[ "${current_dateversion}" ==  "${new_dateversion}" ]]; then
        incremented_patch="$((current_path_number+1))"
    else
        incremented_patch="1"
    fi

    echo "${new_dateversion}.${incremented_patch}"
}


show_current_version() {
    local changes_above_tag=$(echo "${CURRENT_TAG}" | \
        ${SED} -r '/^.*-[0-9]+-[a-z0-9].*/p'      | \
        wc -l                                   | \
        xargs)
    local sanitized_branch_name="$(echo ${CURRENT_BRANCH} | $SED 's/[^a-zA-Z0-9]/-/g')"
    
    if [[ "${changes_above_tag}" -eq 1 ]] && [[ "${CURRENT_BRANCH}" == "${MAIN_BRANCH}" ]]; then
        echo "${LATEST_TAG}"
    else
        local next_tag="$(generate_next_version)"
        echo "${next_tag}-${sanitized_branch_name}-SNAPSHOT"
    fi
}


show_current_version
