#!/bin/bash

# Source wallet addresses and scid from respective files
source wallet_address.dat
source scid.dat

# Function to construct transfer object for a wallet address
construct_transfer() {
    local address="$1"
    local transfer='{
        "scid": "'"$SCID"'",
        "destination": "'"$address"'",
        "amount": 1
    }'
    echo "$transfer"
}

# Construct transfers array
transfers="["
# Transfer to wallet's 1-21
# not 0; can't send to self
for ((i = 1; i <= 21; i++)); do
    addressVar="WALLETADDRESS$i"
    address="${!addressVar}"
    transfer=$(construct_transfer "$address")
    transfers+="$(printf '%s' "$transfer"),"
done
# Remove the trailing comma
transfers="${transfers%,}"
transfers+="]"

# Send the bulk transfer request
curl -X POST \
  http://127.0.0.1:30000/json_rpc \
  -H 'content-type: application/json' \
  -d '{
    "jsonrpc": "2.0",
    "id": "1",
    "method": "transfer",
    "params": {
        "transfers": '"$transfers"',
        "ringsize": 32
    }
}'
