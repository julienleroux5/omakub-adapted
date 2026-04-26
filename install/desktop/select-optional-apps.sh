#!/bin/bash

# Set OMAKUB_PATH if not already set
OMAKUB_PATH=${OMAKUB_PATH:-$HOME/.local/share/omakub}

if [[ -v OMAKUB_FIRST_RUN_OPTIONAL_APPS ]]; then
	apps=$OMAKUB_FIRST_RUN_OPTIONAL_APPS

	if [[ -n "$apps" ]]; then
		for app in $apps; do
			if [ -f "$OMAKUB_PATH/install/desktop/optional/app-${app,,}.sh" ]; then
				source "$OMAKUB_PATH/install/desktop/optional/app-${app,,}.sh"
			else
				echo "Warning: Optional app script not found: $OMAKUB_PATH/install/desktop/optional/app-${app,,}.sh"
			fi
		done
	fi
fi
