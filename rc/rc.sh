#!/bin/sh
WORKDIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# Self installation

# Android base path
export ANDROID_HOME=$HOME/AndroidSDK 
export ANDROID_SDK_ROOT=$ANDROID_HOME

# Node legacy SSL
# export NODE_OPTIONS=--openssl-legacy-provider

# Install aliases
. "$WORKDIR/aliases.sh"

# Add golang to path variable
declare -a paths_to_add=(
    "/usr/local/lib/node_modules"
    "/usr/local/go/bin"
    "/smurfs"
    "$HOME/go/bin"
    "$ANDROID_HOME/tools"
    "$ANDROID_HOME/platform-tools"
    $(yarn global bin)
)
for p in "${paths_to_add[@]}"
do
    if [[ -d "$p" ]]
    then
        export PATH=$PATH:$p
    fi
done

