#!/bin/bash
WALLET_FILE=wallet_addresses.dat
BASEDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
touch "$BASEDIR/$WALLET_FILE"
echo "" > "$BASEDIR/$WALLET_FILE"
for ((i=0; i<=21; i++)); do
    echo "WALLETADDRESS$i=$(
        curl -s \
        -X POST http://127.0.0.1:$((30000 + i))/json_rpc \
        -H 'content-type: application/json' \
        -d '{
             "jsonrpc": "2.0",
             "id": "0",
             "method": "GetAddress"
            }' \
            | jq -r '.result.address'
        )" >> "$BASEDIR/$WALLET_FILE"
done
