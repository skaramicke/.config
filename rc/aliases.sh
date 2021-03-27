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

    unusedsteps() {
        behave -f steps.usage --dry-run 2>/dev/null | awk '/UNUSED STEP DEFINITIONS/','/UNDEFINED/'|grep @
    }

    elmanalyse() {
	    bash -c "! elm-analyse | awk '/Messages:/',EOF | grep -v 'Record has only one field' || exit 1"
    }

    rebase() {
        if git remote show origin | grep -q "mikael.gron"; then
            branch=`git rev-parse --abbrev-ref HEAD`
            git fetch upstream
            git rebase "upstream/$branch"
        else
            echo "unsafe"
        fi
    }

else
    echo "Vars file does not exist. Copy the example file to $vars_path"
fi

