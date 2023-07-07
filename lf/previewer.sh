#!/bin/sh
set +e

if command -v pistol &> /dev/null
then
    export PISTOL_CHROMA_FORMATTER=terminal16m
    export PISTOL_CHROMA_STYLE=nord
    pistol "$@"
else
    bat -p --color always "$@"
fi
