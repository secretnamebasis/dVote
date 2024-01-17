#!/bin/bash
BASEDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

echo "WALLETADDRESS1=$(curl -s -X POST http://127.0.0.1:20201/json_rpc -H 'content-type: application/json' -d '{"jsonrpc": "2.0","id": "0","method": "GetAddress"}' | jq -r '.result.address')" > $BASEDIR/wallet_address1.dat
echo "WALLETADDRESS2=$(curl -s -X POST http://127.0.0.1:20202/json_rpc -H 'content-type: application/json' -d '{"jsonrpc": "2.0","id": "0","method": "GetAddress"}' | jq -r '.result.address')" > $BASEDIR/wallet_address2.dat
echo "WALLETADDRESS3=$(curl -s -X POST http://127.0.0.1:20203/json_rpc -H 'content-type: application/json' -d '{"jsonrpc": "2.0","id": "0","method": "GetAddress"}' | jq -r '.result.address')" > $BASEDIR/wallet_address3.dat
