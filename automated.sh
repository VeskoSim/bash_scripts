#!/bin/bash

if [ -z "$1" ]; then
    echo "No argument"
    echo "Please write argument"
    exit 1
fi

SCRIPTNAME="$1"

echo "#!/bin/bash" > "$SCRIPTNAME"

echo find ~ -type f -mtime 7 >> "$SCRIPTNAME"