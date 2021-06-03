#!/bin/sh
WORKDIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# Self installation


# Install aliases
. "$WORKDIR/aliases.sh"

# Add golang to path variable
declare -a paths_to_add=(
    "/usr/local/go/bin"
    "/smurfs"
    "$HOME/go/bin"
)
for p in "${paths_to_add[@]}"
do
    if [[ -d "$p" ]]
    then
        export PATH=$PATH:$p
    fi
done

