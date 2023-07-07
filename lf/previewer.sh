#!/bin/sh
export PISTOL_CHROMA_FORMATTER=terminal16m
export PISTOL_CHROMA_STYLE=nord
#bat -p --color always "$@"
pistol "$@"
