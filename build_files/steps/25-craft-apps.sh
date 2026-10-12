#!/bin/bash
# Storytold's Craft apps (https://github.com/storytold), installed from each
# project's latest stable GitHub release. Lindle images rebuild daily, so a new
# Craft release reaches users with the next OS update.
#
# Required apps fail the build if they can't be installed. Optional apps (none
# right now) are skipped until their project publishes a stable release.

set -ouex pipefail

required=(wordcraft gridcraft deckcraft photocraft)
optional=()

arch="$(uname -m)"
work="$(mktemp -d)"

# Prints the latest stable release tag (e.g. v0.3.1), or nothing if there is none.
latest_tag() {
    local url
    url="$(curl -fsSL --retry 3 -o /dev/null -w '%{url_effective}' \
        "https://github.com/storytold/$1/releases/latest")" || return 0
    case "$url" in
        */releases/tag/*) echo "${url##*/}" ;;
    esac
}

install_app() {
    local app="$1" tag version rpm base
    tag="$(latest_tag "$app")"
    if [[ -z "$tag" ]]; then
        echo "No stable release of $app yet"
        return 1
    fi
    version="${tag#v}"
    rpm="$app-$version-linux-$arch.rpm"
    base="https://github.com/storytold/$app/releases/download/$tag"

    # Explicit "|| return 1": errexit is off when the caller uses "||".
    curl -fsSL --retry 3 -o "$work/$rpm" "$base/$rpm" || return 1
    curl -fsSL --retry 3 -o "$work/$app-SHA256SUMS.txt" "$base/SHA256SUMS.txt" || return 1
    (
        cd "$work" &&
            awk -v f="$rpm" '$2 == f || $2 == "*" f { print; found = 1 } END { exit !found }' \
                "$app-SHA256SUMS.txt" | sha256sum --check -
    ) || return 1

    dnf5 install -y "$work/$rpm" || return 1
}

for app in "${required[@]}"; do
    install_app "$app"
done

for app in "${optional[@]+"${optional[@]}"}"; do
    install_app "$app" || echo "Skipping $app for now"
done

rm -rf "$work"
