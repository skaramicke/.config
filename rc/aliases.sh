#!/bin/bash

rc_dir=$(realpath $(dirname ${BASH_SOURCE[0]}))
vars_path="$rc_dir/vars.sh"

if [ -f "$vars_path" ]
then
    . "$vars_path"

    require() {
        if [ ! -v $1 ]; then
            echo "$1 not specified in vars file"
        fi
    }

    require "private_email"
    require "work_email"
    require "full_name"

    gitwho() {
        if [ -d .git ]
        then
            name="Mikael Grön"
            if [ "$1" = "work" ]
            then
                email=$work_email
            else
                email=$private_email
            fi
            git config user.name $name
            git config user.email $email
            echo "Git ID: $name <$email>"
        else
            echo "Not a git repo"
        fi
    }

    ac() {
        if [ -d .venv ]
        then
            . .venv/bin/activate
        elif [ -d .env ]
        then
            . .env/bin/activate
        else
            echo "No virtual environment detected"
        fi
    }

    deac() {
        deactivate
    }

    obehave() {
        if [ "$1" = "all" ]
        then
            behave -q -k
        else
            behave --tags=-wip --tags=-skip -q -k
        fi
    }

else
    echo "Vars file does not exist. Copy the example file to $vars_path"
fi

