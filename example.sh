#!/bin/bash

set -eou pipefail

cd "$(dirname $0)"

commit=$(/usr/local/bin/green mycorp/some-cfg master || true)
if [[ -z "${commit}" ]]; then
	# Branch is currently broken, skip
	exit 0
fi

current=$(git rev-parse HEAD)

if [[ "${commit}" == "${current}" ]]; then
	# We are already at last green, nothing to do
	exit 0
fi

# Fetch all
git fetch -q
# Fast-forward to last green
git pull -q origin "${commit}"
