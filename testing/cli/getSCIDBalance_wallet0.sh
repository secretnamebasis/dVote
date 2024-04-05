#!/bin/bash

BASEDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source $BASEDIR/scid.dat

curl -s -X POST http://127.0.0.1:30000/json_rpc -H 'content-type: application/json' -d '{"jsonrpc": "2.0","id": "1","method": "GetBalance","params": {"scid": "'$SCID'"}}' | jq
