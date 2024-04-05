#!/bin/bash

BASEDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source $BASEDIR/scid.dat

FUNCTION="$1"
DEROVALUE="$2"
TOKENVALUE="$3"
shift
shift
shift

$BASEDIR/controller.sh $FUNCTION $IP:$PORT $DEROVALUE $TOKENVALUE $SCID "$@"
